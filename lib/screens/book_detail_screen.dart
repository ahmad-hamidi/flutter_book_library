import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:books_app/config/routes.gr.dart';
import 'package:books_app/models/book_model.dart';
import 'package:books_app/providers/detail_provider.dart';
import 'package:books_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailScreen extends StatelessWidget {
  BookDetailScreen({@PathParam('bookId') this.bookId});

  final String? bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            if (_isBookListNotEmpty(context)) {
              Navigator.pop(context);
            } else {
              context.pushRoute(HomeScreen());
            }
          },
        ),
      ),
      bottomNavigationBar: _bottomNavWidget(),
      body: FutureBuilder<BookModel?>(
        future: DetailProvider().getBookDetail(this.bookId),
        builder: (context, apiResponse) {
          final bookModel = apiResponse.data;
          DetailProvider.bookUrl = bookModel?.bookUrl;

          if (apiResponse.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (apiResponse.connectionState == ConnectionState.done &&
              bookModel == null) {
            return Center(
              child: Text(
                "Data not found",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "${bookModel?.title}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "${bookModel?.subtitle ?? "-"}",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Image.network(bookModel?.thumbnail ?? "")),
                Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: HtmlWidget(bookModel?.description ?? "-")),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isBookListNotEmpty(BuildContext context) {
    return Provider.of<HomeProvider>(context, listen: false).books.isNotEmpty;
  }

  Widget _bottomNavWidget() {
    final widget = Container(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Buy Book",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
    return InkWell(
      child: widget,
      onTap: () async {
        final _url = DetailProvider.bookUrl;
        if (_url != null) {
          if (!await launch(_url)) throw 'Could not launch $_url';
        }
      },
    );
  }
}
