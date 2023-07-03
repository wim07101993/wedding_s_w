import 'package:admin_app/shared/json_extensions.dart';
import 'package:flutter/foundation.dart';

class FeatureFlags {
  const FeatureFlags({
    required this.guestbookIsVisibleAfter,
    required this.djSuggestionsIsVisibleAfter,
  });

  factory FeatureFlags.fromFirebase(Map<String, dynamic> remoteValue) {
    return FeatureFlags(
      guestbookIsVisibleAfter: remoteValue.get('guestbookIsVisibleAfter'),
      djSuggestionsIsVisibleAfter:
          remoteValue.get('djSuggestionsIsVisibleAfter'),
    );
  }

  final DateTime guestbookIsVisibleAfter;
  final DateTime djSuggestionsIsVisibleAfter;

  bool get shouldGuestbookBeVisible =>
      kDebugMode || guestbookIsVisibleAfter.isBefore(DateTime.now());

  bool get shouldDjSuggestionsBeVisible =>
      kDebugMode || djSuggestionsIsVisibleAfter.isBefore(DateTime.now());
}
