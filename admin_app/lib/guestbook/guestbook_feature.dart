import 'package:admin_app/guestbook/behaviours/delete_guestbook_entry.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/guestbook.dart';

class GuestbookFeature extends SharedGuestbookFeature {
  const GuestbookFeature();

  @override
  void registerTypes(GetIt getIt) {
    super.registerTypes(getIt);
    getIt.registerFactory(
      () => DeleteGuestbookEntry(
        monitor: getIt(),
        firestore: getIt(),
        storage: getIt(),
        guestbookPagingController: getIt(),
      ),
    );
  }
}
