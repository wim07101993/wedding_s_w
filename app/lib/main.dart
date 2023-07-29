import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/home/widgets/home_screen.dart';
import 'package:wedding_s_w/features/song_requests/song_requests_feature.dart';
import 'package:wedding_s_w/shared/dependency_management/feature_manager.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';
import 'package:wedding_s_w/shared/firebase/firebase_feature.dart';
import 'package:wedding_s_w/shared/logging/logging_feature.dart';
import 'package:wedding_s_w/shared/theme/theme.dart';

final firebaseFeature = FirebaseFeature();

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
