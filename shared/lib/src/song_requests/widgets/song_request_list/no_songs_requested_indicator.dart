import 'package:flutter/material.dart';

class NoSongsRequestedIndicator extends StatelessWidget {
  const NoSongsRequestedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(
          Icons.music_note,
          color: theme.primaryColor,
          size: 48,
        ),
        const SizedBox(height: 16),
        const Text('Er zijn nog geen liedjes aangevraagd'),
      ],
    );
  }
}
