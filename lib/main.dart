import 'package:books_app/config/routes.gr.dart';
import 'package:books_app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
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
