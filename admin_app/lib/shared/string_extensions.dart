extension StringExtensions on String? {
  String? get nullIfEmpty {
    final s = this;
    return s == null || s.isEmpty ? null : s;
  }
}
