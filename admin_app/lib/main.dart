import 'dart:async';
import 'dart:developer';

import 'package:admin_app/features/routing/app_router.dart';
import 'package:admin_app/features/routing/routing_feature.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/dependency_management/feature_manager.dart';
import 'package:shared/dependency_management/get_it_provider.dart';
import 'package:shared/firebase/firebase_feature.dart';
import 'package:shared/guest_book/guest_book_feature.dart';
import 'package:shared/logging/logging_feature.dart';
import 'package:shared/song_requests/song_requests_feature.dart';
import 'package:shared/theme/theme.dart';

Future<void> main() async {
  final getIt = GetIt.asNewInstance();
  runZonedGuarded(
    () => run(getIt),
    (error, stack) => onError(getIt, error, stack),
  );
}

Future<void> run(GetIt getIt) async {
  final featureManager = FeatureManager(
    features: const [
      LoggingFeature(),
      RoutingFeature(),
      FirebaseFeature(),
      GuestbookFeature(),
      SongRequestsFeature()
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
  if (getIt.isRegistered<FirebaseCrashlytics>()) {
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
    return MaterialApp.router(
      title: 'Trouw Sara & Wim',
      theme: appTheme,
      routerConfig: getIt(context).get<AppRouter>().config(),
    );
  }
}
