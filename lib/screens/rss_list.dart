import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

class RssList extends StatefulWidget {

  RssList({@PathParam('keyUrl') this.keyUrl});
  final String? keyUrl;
  final String title = 'RSS Feed Demo';

  @override
  State<RssList> createState() => _RssListState();
}

class _RssListState extends State<RssList> {
  RssFeed? _feed;
  String? _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String keyItemSession = 'items';
  GlobalKey<RefreshIndicatorState>? _refreshKey;
  List<RssItem> newItems = [];
  List<String> linkItems = [];

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed?.title);
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(
          Uri.parse("https://www.upwork.com/ab/feed/jobs/rss?q=${widget.keyUrl}"),
      headers: {
            "Access-Control-Allow-Origin": "*",
            "Referrer-Policy": "origin-when-cross-origin",
            "Content-Type": "application/rss+xml"
      });
      // print('url ${response.request?.url}');
      var document = XmlDocument.parse(response.body);
      var rss = document.findElements('rss').first;
      var channelElement = rss.findElements('channel').first;
      newItems = channelElement.findElements('item').map((e) {
        var item = RssItem.parse(e);
        linkItems.add(item.link ?? '');
        return item;
      }).toList();

      return RssFeed(
        title: 'Android Kotlin',
        items: newItems,
      );
    } catch (e) {
      log('error loadFeed $e');
    }
    return null;
  }
var isHit = false;
  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getStringList(keyItemSession) == null) {
          prefs.setStringList(keyItemSession, linkItems);
        } else {
          var oldItems = prefs.getStringList(keyItemSession);
          for (var index = 0; index < newItems.length; index++) {
            var list = oldItems?.where((element) => element == newItems[index].link);
            final isNoData = list?.length == 0;
            if (isNoData) {
              final client = http.Client();
              client.get(Uri.parse("https://api.telegram.org/your___telegram_bot_id/sendMessage?text=${newItems[index].link}&chat_id=your_chat_id")).then((value) {
                linkItems.add(newItems[index].link ?? '');
                prefs.setStringList(keyItemSession, linkItems);
              });
            }
          }
        }
      });
    });


  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed?.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed?.items?[index];
        return ListTile(
          title: title(item?.title ?? '-'),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item?.link ?? '-'),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed?.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(_title ?? "Rss List"),
        actions: [
          InkWell(
            onTap: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.setStringList(keyItemSession, []);
                load();
              });
            },
            child: Padding(child: Icon(Icons.clear), padding: EdgeInsets.all(16)),
          )
        ],
      ),
      body: body(),
    ));
  }
}
