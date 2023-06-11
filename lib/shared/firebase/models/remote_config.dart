import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:wedding_s_w/shared/firebase/firebase_remote_config_extensions.dart';
import 'package:wedding_s_w/shared/firebase/models/feature_flags.dart';

class RemoteConfig {
  const RemoteConfig({
    required this.featureFlags,
  });

  factory RemoteConfig.fromFirebase(Map<String, RemoteConfigValue> config) {
    return RemoteConfig(
      featureFlags: config.getObject(
        'featureFlags',
        (remoteValue) => FeatureFlags.fromFirebase(remoteValue),
      ),
    );
  }

  final FeatureFlags featureFlags;
}
