class GuestbookEntry {
  GuestbookEntry({
    required this.id,
    required this.timestamp,
    required this.message,
    required this.pictureUri,
  });

  final String id;
  final DateTime timestamp;
  final String message;
  final String pictureUri;
}
