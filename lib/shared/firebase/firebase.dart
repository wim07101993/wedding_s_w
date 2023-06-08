import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> initializeFirebase(GetIt getIt) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const androidProvider =
      kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity;
  await FirebaseAppCheck.instance.activate(androidProvider: androidProvider);

  getIt.registerSingleton(FirebaseFirestore.instance);
  getIt.registerSingleton(FirebaseStorage.instance);
  getIt.registerSingleton(FirebaseCrashlytics.instance);
}
