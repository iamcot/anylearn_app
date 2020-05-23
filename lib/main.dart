import 'routes.dart';
import 'themes/default.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'anyLearn',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
