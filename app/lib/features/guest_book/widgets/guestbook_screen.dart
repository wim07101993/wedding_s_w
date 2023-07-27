import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/add_guestbook_entry_button.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_entry_list.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

@RoutePage()
class GuestbookScreen extends StatefulWidget {
  const GuestbookScreen({super.key});

  @override
  State<GuestbookScreen> createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  Future<void> onAddGuestbookEntry() async {
    final getIt = this.getIt;
    final entry = await getIt
        .get<AppRouter>()
        .push<GuestbookEntry?>(const TakePictureRoute());
    if (entry == null) {
      return;
    }
    final pagingController = getIt<GuestbookPagingController>();
    pagingController.itemList = [
      entry,
      ...pagingController.itemList ?? [],
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const GuestbookEntryList(),
      floatingActionButton: AddGuestbookEntryButton(
        onTap: onAddGuestbookEntry,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
