import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/shared/dependency_management/feature.dart';

class FirebaseFeature extends FeatureWithSubscriptions {
  @override
  void registerTypes(GetIt getIt) {
    getIt.registerLazySingleton(() => FirebaseFirestore.instance);
    getIt.registerLazySingleton(() => FirebaseStorage.instance);
    getIt.registerLazySingleton(() => FirebaseCrashlytics.instance);
    getIt.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  }

  @override
  Future<void> install(GetIt getIt) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    const androidProvider =
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity;
    await FirebaseAppCheck.instance.activate(androidProvider: androidProvider);
    await getIt<FirebaseRemoteConfig>().fetchAndActivate();
  }
}
