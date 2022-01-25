import 'package:auto_route/annotations.dart';
import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/screens/home_screen.dart';
import 'package:books_app/screens/not_found_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: BookDetailScreen, path: "/book-detail-screen/:bookId"),
    AutoRoute(page: NotFoundScreen, path: "*"),
  ],
)
class $Routes {}