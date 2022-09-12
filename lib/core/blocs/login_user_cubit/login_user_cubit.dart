import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  final FirebaseAuth firebaseAuth;
  LoginUserCubit({required this.firebaseAuth}) : super(LoginUserInitial());

  Future<void> loginUser() async {
    emit(LoginUserLoading());
    try {
      await firebaseAuth.signInAnonymously();
      emit(LoginUserSuccess());
    } on FirebaseAuthException catch (e) {
      late String loginError;
      switch (e.code) {
        case "operation-not-allowed":
          loginError = "Anonymous auth hasn't been enabled for this project.";
          break;
        case "network-request-failed":
          loginError = "Please check your internet connection and try again";
          break;
        default:
          loginError = "Something went wrong please try again later";
      }
      emit(LoginUserError(loginError));
    }
  }
}
