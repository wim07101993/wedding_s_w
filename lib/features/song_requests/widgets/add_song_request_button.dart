import 'package:flutter/material.dart';

class AddSongRequestButton extends StatelessWidget {
  const AddSongRequestButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: const Text('Aanvragen'),
    );
  }
}
