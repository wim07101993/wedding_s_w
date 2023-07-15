import 'package:shared/json_extensions.dart';

class SpotifyConfig {
  const SpotifyConfig({
    required this.clientId,
    required this.clientSecret,
  });

  factory SpotifyConfig.fromFirebase(Map<String, dynamic> remoteValue) {
    return SpotifyConfig(
      clientId: remoteValue.get('clientId'),
      clientSecret: remoteValue.get('clientSecret'),
    );
  }

  final String clientSecret;
  final String clientId;
}
