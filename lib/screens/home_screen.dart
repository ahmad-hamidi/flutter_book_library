import 'package:auto_route/auto_route.dart';
import 'package:books_app/config/routes.gr.dart';
import 'package:books_app/providers/home_provider.dart';
import 'package:books_app/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  HomeProvider? _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<HomeProvider>(context, listen: false);
    _provider?.getBooks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _provider?.getBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Book App"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.books.length,
                  itemBuilder: (context, position) {
                    final book = provider.books[position];
                    return InkWell(
                      onTap: () {
                        openBookDetail();
                      },
                      child: BookWidget(
                          book.title, book.description, book.thumbnail),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Color(0xffDADADA),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openBookDetail() {
    AutoRouter.of(context).pushNamed(BookDetailScreen().path);
  }
}
