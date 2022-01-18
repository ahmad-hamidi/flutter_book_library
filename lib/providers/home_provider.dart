import 'dart:convert';

import 'package:books_app/models/book_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  List<BookModel> books = [];
  int page = 0;

  Future<void> getBooks() async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=flutter&startIndex=$page&maxResults=40"));

      print("response.body ${response.body}");
      final items = jsonDecode(response.body)['items'];
      List<BookModel> bookList = [];
      for (var item in items) {
        bookList.add(BookModel.fromApi(item));
      }

      books.addAll(bookList);
      page += 40;
      notifyListeners();
    } catch (e) {
      print("error get books $e");
    }
  }
}
