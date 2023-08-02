import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/guestbook.dart';
import 'package:wedding_s_w/features/guestbook/behaviours/save_guest_book_entry.dart';
import 'package:wedding_s_w/features/guestbook/behaviours/take_picture.dart';

typedef GuestbookPagingController = PagingController<DateTime?, GuestbookEntry>;

class GuestbookFeature extends SharedGuestbookFeature {
  const GuestbookFeature();

  @override
  void registerTypes(GetIt getIt) {
    super.registerTypes(getIt);
    getIt.registerFactory(
      () => SaveGuestbookEntry(
        monitor: getIt(),
        storage: getIt(),
        firestore: getIt(),
      ),
    );
    getIt.registerFactory(
      () => TakePicture(
        monitor: getIt(),
        imagePicker: getIt(),
      ),
    );
    getIt.registerLazySingleton(() => ImagePicker());
  }

  @override
  String toString() => 'guestbook feature';
}
