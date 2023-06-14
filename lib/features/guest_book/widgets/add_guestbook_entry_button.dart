import 'package:flutter/material.dart';

class AddGuestbookEntryButton extends StatelessWidget {
  const AddGuestbookEntryButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      label: const Text('Iets in het gastenboek schrijven'),
    );
  }
}
