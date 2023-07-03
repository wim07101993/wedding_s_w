import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

extension FirebaseRemoteConfigMapExtensions on Map<String, RemoteConfigValue> {
  T getObject<T>(String key, T Function(Map<String, dynamic> json) parser) {
    final value = this[key]?.asString();
    if (value == null) {
      throw Exception('Could not find value with key $key');
    }
    final json = jsonDecode(value) as Map<String, dynamic>;
    return parser(json);
  }
}
