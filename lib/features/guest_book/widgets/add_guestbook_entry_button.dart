import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';

class AddGuestbookEntryButton extends StatelessWidget {
  const AddGuestbookEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        AutoRouter.of(context).push(const NewGuestbookEntryRoute());
      },
      label: const Text('Iets in het gastenboek schrijven'),
    );
  }
}
