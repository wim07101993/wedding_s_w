import 'package:behaviour/behaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/firebase/firebase_feature.dart';
import 'package:shared/src/guestbook/behaviours/get_guest_book_entries.dart';
import 'package:shared/src/guestbook/behaviours/get_guestbook_entry.dart';
import 'package:shared/src/guestbook/behaviours/share_picture.dart';
import 'package:shared/src/guestbook/models/guestbook_entry.dart';

typedef GuestbookPagingController = PagingController<DateTime?, GuestbookEntry>;

class SharedGuestbookFeature extends Feature {
  const SharedGuestbookFeature();

  @override
  @mustCallSuper
  List<Type> get dependencies => const [FirebaseFeature];

  @override
  @mustCallSuper
  void registerTypes(GetIt getIt) {
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
      () => SharePicture(
        monitor: getIt(),
      ),
    );
    getIt.registerLazySingleton(
      () {
        final controller = GuestbookPagingController(firstPageKey: null);
        controller.addPageRequestListener((lastEntryTimestamp) {
          getIt<GetGuestBookEntries>()(
            GuestbookPageQuery(lastItemTime: lastEntryTimestamp),
          ).thenWhen(
            (exception) => controller.error = exception,
            (value) =>
                controller.appendPage(value, value.lastOrNull?.timestamp),
          );
        });
        return controller;
      },
      dispose: (controller) => controller.dispose(),
    );
  }

  @override
  String toString() => 'guestbook feature';
}
