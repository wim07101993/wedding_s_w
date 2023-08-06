import 'package:admin_app/guestbook/widgets/guestbook_entry_with_delete_button.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/guestbook.dart';

class GuestbookEntryList extends StatelessWidget {
  const GuestbookEntryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt(context).get<GuestbookPagingController>();
    return PagedListView<DateTime?, GuestbookEntry>(
      pagingController: controller,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, entry, index) => Padding(
          padding: itemPadding(
            controller.value.itemList?.length ?? 0,
            index,
          ),
          child: GuestbookEntryWithDeleteButton(entry: entry),
        ),
      ),
    );
  }

  EdgeInsets itemPadding(int itemCount, int itemIndex) {
    if (itemIndex == 0) {
      return const EdgeInsets.fromLTRB(16, 16, 16, 8);
    } else if (itemIndex >= (itemCount - 1)) {
      return const EdgeInsets.fromLTRB(16, 8, 16, 92);
    } else {
      return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
    }
  }
}
