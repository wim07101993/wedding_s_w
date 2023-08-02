import 'package:admin_app/guestbook/widgets/guestbook_entry_list.dart';
import 'package:flutter/material.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/guestbook.dart';

class GuestbookScreen extends StatelessWidget {
  const GuestbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt(context).get<GuestbookPagingController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(controller.refresh),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              GuestbookHeader(),
              GuestbookEntryList(),
            ],
          ),
        ),
      ),
    );
  }
}
