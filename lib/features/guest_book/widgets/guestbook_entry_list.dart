import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/models/guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_card.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class GuestbookEntryList extends StatefulWidget {
  const GuestbookEntryList({
    super.key,
    required this.controller,
  });

  final PagingController<DateTime?, GuestbookEntry> controller;

  @override
  State<GuestbookEntryList> createState() => _GuestbookEntryListState();
}

class _GuestbookEntryListState extends State<GuestbookEntryList> {
  late final getGuestbookEntries = getIt<GetGuestBookEntries>();

  @override
  void initState() {
    super.initState();
    widget.controller.addPageRequestListener(fetchPage);
  }

  Future<void> fetchPage(DateTime? lastEntryTimestamp) async {
    final response = await getGuestbookEntries(
      GuestbookPageQuery(lastItemTime: lastEntryTimestamp),
    );
    if (!mounted) {
      return;
    }
    response.when(
      (exception) => widget.controller.error = exception,
      (value) => widget.controller.appendPage(
        value,
        value.lastOrNull?.timestamp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => widget.controller.refresh()),
      child: PagedListView<DateTime?, GuestbookEntry>(
        pagingController: widget.controller,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            final itemCount = widget.controller.value.itemList?.length ?? 0;
            EdgeInsets padding;
            if (index == 0) {
              padding = const EdgeInsets.fromLTRB(16, 16, 16, 8);
            } else if (index >= (itemCount - 1)) {
              padding = const EdgeInsets.fromLTRB(16, 8, 16, 92);
            } else {
              padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
            }
            return Padding(
              padding: padding,
              child:
                  GuestbookEntryCard(key: Key(item.id), guestbookEntry: item),
            );
          },
        ),
      ),
    );
  }
}
