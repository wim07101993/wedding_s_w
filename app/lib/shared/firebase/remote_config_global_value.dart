import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:wedding_s_w/shared/dependency_management/global_value.dart';
import 'package:wedding_s_w/shared/firebase/models/remote_config.dart';

class RemoteConfigGlobalValue implements ReadOnlyGlobalValue<RemoteConfig> {
  RemoteConfigGlobalValue({
    required this.firebaseRemoteConfig,
    required this.logger,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;
  final StreamController<RemoteConfig> _streamController =
      StreamController.broadcast();
  final Logger logger;

  RemoteConfig? _value;
  StreamSubscription? remoteChangesSubscription;

  @override
  Stream<RemoteConfig> get changes => _streamController.stream;

  @override
  RemoteConfig get value => _value ?? getValueFromFirebase();

  @override
  Future<ReadOnlyGlobalValue<RemoteConfig>> initialize() async {
    if (!kIsWeb) {
      remoteChangesSubscription =
          firebaseRemoteConfig.onConfigUpdated.listen((event) {
        logger.fine('got update from firebase');
        updateValue();
      });
    }
    await updateValue();
    return this;
  }

  Future<void> updateValue() async {
    await firebaseRemoteConfig.fetchAndActivate();
    getValueFromFirebase();
  }

  RemoteConfig getValueFromFirebase() {
    final remote = firebaseRemoteConfig.getAll();
    final newValue = RemoteConfig.fromFirebase(remote);
    _value = newValue;
    _streamController.add(newValue);
    return newValue;
  }

  FutureOr<void> dispose() => remoteChangesSubscription?.cancel();
}
