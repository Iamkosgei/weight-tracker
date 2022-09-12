import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/data/repositories/weights_repostory.dart';
import 'package:fitness/views/common_widgets/common_snackbar.dart';
import 'package:get_it/get_it.dart';

import '../services/auth_service.dart';

GetIt inject = GetIt.instance;

Future<void> setUpLocator() async {
  inject.registerSingleton<WeightsRepository>(
    WeightsRepositoryImpl(
      FirebaseFirestore.instance,
      FirebaseAuth.instance,
    ),
  );

  inject.registerSingleton<AuthService>(AuthServiceImp(FirebaseAuth.instance));

  inject.registerSingleton(CommonSnackbar());
}
