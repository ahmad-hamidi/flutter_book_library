import 'package:auto_route/annotations.dart';
import 'package:books_app/screens/book_detail_screen.dart';
import 'package:books_app/screens/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Route,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: BookDetailScreen),
  ],
)
class $Routes {}