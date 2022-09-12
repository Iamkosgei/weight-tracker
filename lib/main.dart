import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/configs/app_theme.dart';
import 'package:fitness/configs/colors.dart';
import 'package:fitness/core/navigation/routes.dart';
import 'package:fitness/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injector.dart';
import 'core/navigation/named_navigation.dart';
import 'core/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  bool userLoggedIn = inject.get<AuthService>().userLoggedIn();

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(
    userLoggedIn: userLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool userLoggedIn;
  const MyApp({Key? key, required this.userLoggedIn}) : super(key: key);

  get loginRoute => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(AppColors()).appTheme,
      onGenerateRoute: generateRoute,
      initialRoute: userLoggedIn ? homeRoute : loginRoute,
    );
  }
}
