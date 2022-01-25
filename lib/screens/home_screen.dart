import 'package:auto_route/auto_route.dart';
import 'package:books_app/config/routes.gr.dart';
import 'package:books_app/models/book_model.dart';
import 'package:books_app/providers/home_provider.dart';
import 'package:books_app/widgets/book_widget.dart';
import 'package:books_app/widgets/bottom_sheet_widget.dart';
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
        _getBooksApi();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) => SafeArea(
        top: true,
        child: Scaffold(
          floatingActionButton: _floatingActionWidget(),
          body: Column(
            children: [
              _toolbar(),
              Expanded(
                child: Stack(
                  children: [
                    Container(
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
                              _openBookDetail(book);
                            },
                            child: BookWidget(
                                book.title,
                                book.subtitle ?? book.description,
                                book.thumbnail),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Color(0xffDADADA),
                          );
                        },
                      ),
                    ),
                    provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openBookDetail(BookModel book) {
    print("book.id ${book.id}");
    context.pushRoute(
      BookDetailScreen(bookId: book.id),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Book Library",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void _openSearchBottomSheet() {
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        elevation: 10,
        isScrollControlled: true,
        builder: (ctx) {
          return FractionallySizedBox(
            heightFactor: MediaQuery.of(context).viewInsets.bottom == 0 ? 0.3 : 0.7,
            child: BottomSheetWidget(),
          );
        }).then((value) {
          if (value != null) {
            _provider?.query = value;
            _provider?.books.clear();
            _getBooksApi();
          }
    });
  }

  Widget _floatingActionWidget() {
    return Container(
      child: RawMaterialButton(
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        elevation: 2,
        fillColor: Colors.blue,
        child: Icon(
          Icons.search_outlined,
          size: 38,
          color: Colors.white,
        ),
        onPressed: () {
          _openSearchBottomSheet();
        },
      ),
    );
  }

  void _getBooksApi() {
    _provider?.showLoading();
    _provider?.getBooks();
  }
}
