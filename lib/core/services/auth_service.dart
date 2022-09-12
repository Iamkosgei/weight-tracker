import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  bool userLoggedIn();
  Future<bool> logoutuser();
}

class AuthServiceImp implements AuthService {
  final FirebaseAuth firebaseAuth;

  AuthServiceImp(this.firebaseAuth);
  @override
  bool userLoggedIn() {
    try {
      User? user = firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logoutuser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      log('Error $e');
      return false;
    }
  }
}
