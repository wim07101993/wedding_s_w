import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> initializeFirebase(GetIt getIt) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  getIt.registerSingleton(FirebaseFirestore.instance);
  getIt.registerSingleton(FirebaseStorage.instance);
  getIt.registerSingleton(FirebaseCrashlytics.instance);
}
