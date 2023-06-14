import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/shared/dependency_management/feature.dart';
import 'package:wedding_s_w/shared/firebase/firebase_feature.dart';

class GuestbookFeature extends Feature {
  const GuestbookFeature();

  @override
  List<Type> get dependencies => const [FirebaseFeature];

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerFactory(
      () => SaveGuestbookEntry(
        monitor: getIt(),
        storage: getIt(),
        firestore: getIt(),
      ),
    );
    getIt.registerFactory(
      () => GetGuestBookEntries(
        monitor: getIt(),
        firestore: getIt(),
        getGuestbookEntryPicture: getIt(),
      ),
    );
    getIt.registerFactory(
      () => GetGuestbookEntryPicture(monitor: getIt(), storage: getIt()),
    );
  }
}
