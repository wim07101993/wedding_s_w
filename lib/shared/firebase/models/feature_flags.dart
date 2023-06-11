import 'package:flutter/foundation.dart';
import 'package:wedding_s_w/shared/json_extensions.dart';

class FeatureFlags {
  const FeatureFlags({
    required this.guestbookIsVisibleAfter,
  });

  factory FeatureFlags.fromFirebase(Map<String, dynamic> remoteValue) {
    return FeatureFlags(
      guestbookIsVisibleAfter: remoteValue.get('guestbookIsVisibleAfter'),
    );
  }

  final DateTime guestbookIsVisibleAfter;

  bool get shouldGuestbookBeVisible =>
      kDebugMode || guestbookIsVisibleAfter.isBefore(DateTime.now());
}
