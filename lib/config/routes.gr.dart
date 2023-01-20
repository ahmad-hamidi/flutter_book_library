// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screens/book_detail_screen.dart' as _i3;
import '../screens/ecommerce_benchamrk.dart' as _i1;
import '../screens/home_screen.dart' as _i2;
import '../screens/not_found_screen.dart' as _i5;
import '../screens/rss_list.dart' as _i4;

class Routes extends _i6.RootStackRouter {
  Routes([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    EcommerceBenchmark.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EcommerceBenchmark(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    BookDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookDetailScreenArgs>(
          orElse: () =>
              BookDetailScreenArgs(bookId: pathParams.optString('bookId')));
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.BookDetailScreen(bookId: args.bookId),
      );
    },
    RssList.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RssListArgs>(
          orElse: () => RssListArgs(keyUrl: pathParams.optString('keyUrl')));
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.RssList(keyUrl: args.keyUrl),
      );
    },
    NotFoundScreen.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.NotFoundScreen(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          EcommerceBenchmark.name,
          path: '/',
        ),
        _i6.RouteConfig(
          HomeScreen.name,
          path: '/home',
        ),
        _i6.RouteConfig(
          BookDetailScreen.name,
          path: '/book-detail-screen/:bookId',
        ),
        _i6.RouteConfig(
          RssList.name,
          path: '/rss-list/:keyUrl',
        ),
        _i6.RouteConfig(
          NotFoundScreen.name,
          path: '*',
        ),
      ];
}

/// generated route for
/// [_i1.EcommerceBenchmark]
class EcommerceBenchmark extends _i6.PageRouteInfo<void> {
  const EcommerceBenchmark()
      : super(
          EcommerceBenchmark.name,
          path: '/',
        );

  static const String name = 'EcommerceBenchmark';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i6.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '/home',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i3.BookDetailScreen]
class BookDetailScreen extends _i6.PageRouteInfo<BookDetailScreenArgs> {
  BookDetailScreen({String? bookId})
      : super(
          BookDetailScreen.name,
          path: '/book-detail-screen/:bookId',
          args: BookDetailScreenArgs(bookId: bookId),
          rawPathParams: {'bookId': bookId},
        );

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
/// [_i4.RssList]
class RssList extends _i6.PageRouteInfo<RssListArgs> {
  RssList({String? keyUrl})
      : super(
          RssList.name,
          path: '/rss-list/:keyUrl',
          args: RssListArgs(keyUrl: keyUrl),
          rawPathParams: {'keyUrl': keyUrl},
        );

  static const String name = 'RssList';
}

class RssListArgs {
  const RssListArgs({this.keyUrl});

  final String? keyUrl;

  @override
  String toString() {
    return 'RssListArgs{keyUrl: $keyUrl}';
  }
}

/// generated route for
/// [_i5.NotFoundScreen]
class NotFoundScreen extends _i6.PageRouteInfo<void> {
  const NotFoundScreen()
      : super(
          NotFoundScreen.name,
          path: '*',
        );

  static const String name = 'NotFoundScreen';
}
