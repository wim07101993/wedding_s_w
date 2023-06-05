import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart';
import 'package:wedding_s_w/shared/routing.dart';

class GuestbookScreen extends StatefulWidget {
  const GuestbookScreen({super.key});

  @override
  State<GuestbookScreen> createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('TODO gastenboek items'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(route<NewGuestbookEntryScreen>());
        },
        label: Text('Iets in het gastenboek schrijven'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
