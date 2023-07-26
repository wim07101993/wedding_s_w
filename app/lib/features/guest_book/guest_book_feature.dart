import 'package:behaviour/behaviour.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guest_book_entries.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/get_guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/shared/dependency_management/feature.dart';
import 'package:wedding_s_w/shared/firebase/firebase_feature.dart';

typedef GuestbookPagingController = PagingController<DateTime?, GuestbookEntry>;

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
      () => GetGuestbookEntry(
        monitor: getIt(),
        firestore: getIt(),
        storage: getIt(),
      ),
    );
    getIt.registerFactory(
      () => GetGuestBookEntries(
        monitor: getIt(),
        firestore: getIt(),
        storage: getIt(),
      ),
    );
    getIt.registerFactory(
      () => TakePicture(
        monitor: getIt(),
        imagePicker: getIt(),
      ),
    );
    getIt.registerLazySingleton(
      () => GuestbookPagingController(firstPageKey: null),
    );
  }

  @override
  Future<void> install(GetIt getIt) {
    final guestbookPagingController = getIt<GuestbookPagingController>();
    guestbookPagingController.addPageRequestListener((lastEntryTimestamp) {
      getIt<GetGuestBookEntries>()(
        GuestbookPageQuery(lastItemTime: lastEntryTimestamp),
      ).thenWhen(
        (exception) => guestbookPagingController.error = exception,
        (value) => guestbookPagingController.appendPage(
          value,
          value.lastOrNull?.timestamp,
        ),
      );
    });
    return Future.value();
  }
}
