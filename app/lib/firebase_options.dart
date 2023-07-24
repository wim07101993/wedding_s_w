// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCgNgHIy2k7pjL502Ujbb0cNl2XOAmoUVA',
    appId: '1:462131427503:web:a0d6ff441fd8e5c89abc5a',
    messagingSenderId: '462131427503',
    projectId: 'weddingsw-3c88a',
    authDomain: 'weddingsw-3c88a.firebaseapp.com',
    storageBucket: 'weddingsw-3c88a.appspot.com',
    measurementId: 'G-P4LP05FK8L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkOiLHYZkYgduCxxdXK8xSTxgZOYnzB2w',
    appId: '1:462131427503:android:9ca0cb4be34b00539abc5a',
    messagingSenderId: '462131427503',
    projectId: 'weddingsw-3c88a',
    storageBucket: 'weddingsw-3c88a.appspot.com',
  );
}

const recaptchaKey = '6Lf5c04nAAAAAOniLgv6Dt_VFpwqQ4wnIJVLga23';
