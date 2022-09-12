import 'package:fitness/core/navigation/routes.dart';
import 'package:fitness/views/pages/home_page/home_page.dart';
import 'package:fitness/views/pages/login_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
