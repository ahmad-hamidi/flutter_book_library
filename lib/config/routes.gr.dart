// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../screens/book_detail_screen.dart' as _i2;
import '../screens/home_screen.dart' as _i1;

class Routes extends _i3.RootStackRouter {
  Routes([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    BookDetailScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.BookDetailScreen());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomeScreen.name, path: '/'),
        _i3.RouteConfig(BookDetailScreen.name, path: '/book-detail-screen')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreen extends _i3.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i2.BookDetailScreen]
class BookDetailScreen extends _i3.PageRouteInfo<void> {
  const BookDetailScreen()
      : super(BookDetailScreen.name, path: '/book-detail-screen');

  static const String name = 'BookDetailScreen';
}
