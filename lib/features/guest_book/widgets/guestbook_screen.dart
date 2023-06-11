import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/widgets/add_guestbook_entry_button.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_list.dart';

@RoutePage()
class GuestbookScreen extends StatelessWidget {
  const GuestbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GuestbookEntryList(),
      floatingActionButton: AddGuestbookEntryButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
