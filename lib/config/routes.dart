import 'package:auto_route/annotations.dart';
import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/screens/home_screen.dart';
import 'package:books_app/screens/not_found_screen.dart';
import 'package:books_app/screens/rss_list.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: BookDetailScreen, path: "/book-detail-screen/:bookId"),
    AutoRoute(page: RssList, path: "/rss-list/:keyUrl"),
    AutoRoute(page: NotFoundScreen, path: "*"),
  ],
)
class $Routes {}