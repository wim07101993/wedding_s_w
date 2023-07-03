import 'package:admin_app/shared/firebase/firebase_remote_config_extensions.dart';
import 'package:admin_app/shared/firebase/models/feature_flags.dart';
import 'package:admin_app/shared/firebase/models/spotify_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  const RemoteConfig({
    required this.featureFlags,
    required this.spotify,
  });

  factory RemoteConfig.fromFirebase(Map<String, RemoteConfigValue> config) {
    return RemoteConfig(
      featureFlags: config.getObject(
        'featureFlags',
        (json) => FeatureFlags.fromFirebase(json),
      ),
      spotify: config.getObject(
        'spotify',
        (json) => SpotifyConfig.fromFirebase(json),
      ),
    );
  }

  final FeatureFlags featureFlags;
  final SpotifyConfig spotify;
}
