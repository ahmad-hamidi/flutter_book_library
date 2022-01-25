// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/book_detail_screen.dart' as _i2;
import '../screens/home_screen.dart' as _i1;
import '../screens/not_found_screen.dart' as _i3;

class Routes extends _i4.RootStackRouter {
  Routes([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    BookDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookDetailScreenArgs>(
          orElse: () =>
              BookDetailScreenArgs(bookId: pathParams.optString('bookId')));
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.BookDetailScreen(bookId: args.bookId));
    },
    NotFoundScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.NotFoundScreen());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeScreen.name, path: '/'),
        _i4.RouteConfig(BookDetailScreen.name,
            path: '/book-detail-screen/:bookId'),
        _i4.RouteConfig(NotFoundScreen.name, path: '*')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreen extends _i4.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i2.BookDetailScreen]
class BookDetailScreen extends _i4.PageRouteInfo<BookDetailScreenArgs> {
  BookDetailScreen({String? bookId})
      : super(BookDetailScreen.name,
            path: '/book-detail-screen/:bookId',
            args: BookDetailScreenArgs(bookId: bookId),
            rawPathParams: {'bookId': bookId});

  static const String name = 'BookDetailScreen';
}

class BookDetailScreenArgs {
  const BookDetailScreenArgs({this.bookId});

  final String? bookId;

  @override
  String toString() {
    return 'BookDetailScreenArgs{bookId: $bookId}';
  }
}

/// generated route for
/// [_i3.NotFoundScreen]
class NotFoundScreen extends _i4.PageRouteInfo<void> {
  const NotFoundScreen() : super(NotFoundScreen.name, path: '*');

  static const String name = 'NotFoundScreen';
}
