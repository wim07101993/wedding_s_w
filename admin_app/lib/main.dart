import 'dart:async';
import 'dart:developer';

import 'package:admin_app/firebase_options.dart';
import 'package:admin_app/guestbook/guestbook_feature.dart';
import 'package:admin_app/home/widgets/home_screen.dart';
import 'package:admin_app/song_requests/song_requests_feature.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/firebase.dart';
import 'package:shared/logging.dart';
import 'package:shared/song_requests.dart';
import 'package:shared/theme/theme.dart';

final firebaseFeature = FirebaseFeature(
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  recaptchaKey: recaptchaKey,
);

Future<void> main() async {
  final getIt = GetIt.asNewInstance();
  runZonedGuarded(
    () => run(getIt),
    (error, stack) => onError(getIt, error, stack),
  );
}

Future<void> run(GetIt getIt) async {
  final featureManager = FeatureManager(
    features: [
      const LoggingFeature(),
      firebaseFeature,
      const GuestbookFeature(),
      const SongRequestsFeature()
    ],
    getIt: getIt,
  )..registerTypes();

  await featureManager.install();

  runApp(
    GetItProvider(
      getIt: getIt,
      child: const MyApp(),
    ),
  );
}

void onError(GetIt getIt, dynamic error, StackTrace stack) {
  if (firebaseFeature.isInstalled &&
      getIt.isRegistered<FirebaseCrashlytics>()) {
    getIt<FirebaseCrashlytics>().recordError(error, stack);
  } else {
    log('ERROR: $error at $stack');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trouw Sara & Wim',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
