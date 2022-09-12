import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/configs/assets.dart';
import 'package:fitness/core/blocs/login_user_cubit/login_user_cubit.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:fitness/core/navigation/routes.dart';
import 'package:fitness/views/common_widgets/common_snackbar.dart';
import 'package:fitness/views/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView(
          children: [
            SizedBox(
              height: 260,
              child: SvgPicture.asset(
                Assets.indoorBikeSvg,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Weight tracker',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Award Winning Weight Tracker App developed as a tool mainly to help motivate a person following a diet and/or exercise program to reach their desired target weight within a predefined period.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque cursus non turpis sit amet dapibus. Morbi augue mauris, aliquet quis magna ut, egestas bibendum nisi. Etiam fringilla urna quis orci dapibus dapibus. Ve',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.6,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            BlocProvider(
                create: (context) =>
                    LoginUserCubit(firebaseAuth: FirebaseAuth.instance),
                child: BlocConsumer<LoginUserCubit, LoginUserState>(
                  listener: (context, state) {
                    if (state is LoginUserSuccess) {
                      inject.get<CommonSnackbar>().show(context, "Welcome");
                      Navigator.pushNamedAndRemoveUntil(
                          context, homeRoute, (route) => false);
                    } else if (state is LoginUserError) {
                      inject.get<CommonSnackbar>().show(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      loading: state is LoginUserLoading,
                      onPressed: () {
                        context.read<LoginUserCubit>().loginUser();
                      },
                      text: 'CONTINUE',
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
