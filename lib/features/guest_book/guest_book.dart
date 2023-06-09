import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry_picture.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';

void initializeGuestbook(GetIt getIt) {
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
