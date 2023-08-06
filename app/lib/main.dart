import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/firebase.dart';
import 'package:shared/home.dart';
import 'package:shared/logging.dart';
import 'package:shared/song_requests.dart';
import 'package:shared/theme/theme.dart';
import 'package:wedding_s_w/features/guestbook/guest_book_feature.dart';
import 'package:wedding_s_w/features/guestbook/widgets/guestbook_screen.dart';
import 'package:wedding_s_w/features/song_requests/widgets/song_requests_screen.dart';
import 'package:wedding_s_w/firebase_options.dart';

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
      SharedSongRequestsFeature()
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
      home: const HomeScreen(
        guestbook: GuestbookScreen(),
        songRequests: SongRequestsScreen(),
      ),
    );
  }
}
