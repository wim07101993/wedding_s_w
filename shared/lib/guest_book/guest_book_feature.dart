import 'package:get_it/get_it.dart';
import 'package:shared/dependency_management/feature.dart';
import 'package:shared/firebase/firebase_feature.dart';
import 'package:shared/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:shared/guest_book/behaviours/get_guestbook_entry_picture.dart';

class GuestbookFeature extends Feature {
  const GuestbookFeature();

  @override
  List<Type> get dependencies => const [FirebaseFeature];

  @override
  void registerTypes(GetIt getIt) {
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
