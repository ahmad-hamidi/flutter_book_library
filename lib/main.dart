import 'package:books_app/config/routes.gr.dart';
import 'package:books_app/providers/home_provider.dart';
import 'package:books_app/helpers/url_strategy_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setUrlWithoutHashTag();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _route = Routes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: _route.defaultRouteParser(),
      routerDelegate: _route.delegate(),
    );
  }
}
