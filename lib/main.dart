import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart';
import 'package:wedding_s_w/features/home/widgets/home_screen.dart';
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart';
import 'package:wedding_s_w/shared/firebase/firebase.dart';
import 'package:wedding_s_w/shared/get_it_provider.dart';
import 'package:wedding_s_w/shared/routing.dart';
import 'package:wedding_s_w/shared/theme/theme.dart';

Future<void> main() async {
  final getIt = GetIt.asNewInstance();
  runZonedGuarded(
    () => runMyApp(getIt),
    (error, stack) => onError(getIt, error, stack),
  );
}

Future<void> runMyApp(GetIt getIt) async {
  await initializeFirebase(getIt);
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
    print('ERROR: $error at $stack');
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
      routes: {
        route<HomeScreen>(): (context) => HomeScreen(),
        route<GuestbookScreen>(): (context) => GuestbookScreen(),
        route<InvitationScreen>(): (context) => InvitationScreen(),
        route<NewGuestbookEntryScreen>(): (context) =>
            NewGuestbookEntryScreen(),
      },
      initialRoute: route<HomeScreen>(),
    );
  }
}
