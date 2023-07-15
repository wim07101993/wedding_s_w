import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/guest_book/models/guest_book_entry.dart';
import 'package:shared/guest_book/widgets/guestbook_entry_list.dart';

@RoutePage()
class GuestbookScreen extends StatefulWidget {
  const GuestbookScreen({super.key});

  @override
  State<GuestbookScreen> createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  final pagingController = PagingController<DateTime?, GuestbookEntry>(
    firstPageKey: null,
  );

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GuestbookEntryList(controller: pagingController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
