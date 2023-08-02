import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/src/dependency_management/get_it_provider.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';
import 'package:shared/src/guestbook/shared_guest_book_feature.dart';
import 'package:shared/src/guestbook/widgets/guestbook_entry_card.dart';

class GuestbookEntryList extends StatelessWidget {
  const GuestbookEntryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt(context).get<GuestbookPagingController>();
    return PagedListView<DateTime?, GuestbookEntry>(
      pagingController: controller,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => Padding(
          padding: itemPadding(
            controller.value.itemList?.length ?? 0,
            index,
          ),
          child: GuestbookEntryCard(
            key: Key(item.id),
            guestbookEntry: item,
          ),
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