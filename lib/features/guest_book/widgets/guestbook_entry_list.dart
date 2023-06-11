import 'dart:async';

import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_new_entries_stream.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_card.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class GuestbookEntryList extends StatefulWidget {
  const GuestbookEntryList({super.key});

  @override
  State<GuestbookEntryList> createState() => _GuestbookEntryListState();
}

class _GuestbookEntryListState extends State<GuestbookEntryList> {
  final pagingController = PagingController<DateTime, GuestbookEntry>(
    firstPageKey: DateTime(2100),
  );
  late final getGuestbookEntries = getIt<GetGuestBookEntries>();
  StreamSubscription? _changesSubscription;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener(fetchPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIt<GetNewEntriesStream>()().thenWhenSuccess((stream) {
      return _changesSubscription = stream.listen(
        (entry) => pagingController.itemList = [
          entry,
          ...pagingController.itemList ?? [],
        ],
      );
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    _changesSubscription?.cancel();
    super.dispose();
  }

  Future<void> fetchPage(DateTime lastEntryTimestamp) async {
    final response = await getGuestbookEntries(
      GuestbookPageQuery(lastItemTime: lastEntryTimestamp),
    );
    if (!mounted) {
      return;
    }
    response.when(
      (exception) => pagingController.error = exception,
      (value) => pagingController.appendPage(
        value,
        value.lastOrNull?.timestamp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => pagingController.refresh()),
      child: PagedListView<DateTime, GuestbookEntry>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            final itemCount = pagingController.value.itemList?.length ?? 0;
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
