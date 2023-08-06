import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/firebase/remote_config_global_value.dart';
import 'package:shared/src/logging/logging_feature.dart';

class FirebaseFeature extends Feature {
  FirebaseFeature({
    required this.firebaseOptions,
    required this.recaptchaKey,
  });

  final FirebaseOptions firebaseOptions;
  final String recaptchaKey;

  bool isInstalled = false;

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerLazySingleton(() => FirebaseFirestore.instance);
    getIt.registerLazySingleton(() => FirebaseStorage.instance);
    if (kIsWeb) {
      getIt.registerLazySingleton(() => FirebaseCrashlytics.instance);
    }
    getIt.registerLazySingleton(() => FirebaseRemoteConfig.instance);
    getIt.registerLazySingleton(() => FirebaseAuth.instance);
    getIt.registerLazySingleton(
      () => RemoteConfigGlobalValue(
        firebaseRemoteConfig: getIt(),
        logger: getIt.logger<RemoteConfigGlobalValue>(),
      ),
      dispose: (value) => value.dispose(),
    );
  }

  @override
  Future<void> install(GetIt getIt) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: firebaseOptions);
    await FirebaseAppCheck.instance.activate(
      androidProvider:
          kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
      webRecaptchaSiteKey: recaptchaKey,
    );
    await getIt<FirebaseAuth>().signInAnonymously();
    await getIt<RemoteConfigGlobalValue>().initialize();
    isInstalled = true;
  }

  @override
  String toString() => 'firebase feature';
}
