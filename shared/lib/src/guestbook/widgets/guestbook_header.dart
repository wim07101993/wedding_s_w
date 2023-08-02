import 'package:flutter/material.dart';
import 'package:shared/resources/images.dart';

class GuestbookHeader extends StatelessWidget {
  const GuestbookHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(image: Images.homeHeader),
        Text(
          'TROUW',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        Text(
          'Sara & Wim',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
