import 'package:behaviour/behaviour.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/camera_selector.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/flash_selector.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class CameraControls extends StatefulWidget {
  const CameraControls({
    super.key,
    required this.cameraController,
    required this.cameraDescriptionController,
    required this.cameraList,
    required this.direction,
  });

  final CameraController cameraController;
  final CameraDescriptionController cameraDescriptionController;
  final CameraList cameraList;
  final Axis direction;

  @override
  State<CameraControls> createState() => _CameraControlsState();
}

class _CameraControlsState extends State<CameraControls> {
  Future<void> takePicture() async {
    final picture =
        await getIt<TakePicture>()(widget.cameraController).thenWhen(
      (exception) => null,
      (picture) => picture,
    );
    if (!mounted || picture == null) {
      return;
    }
    await getIt<AppRouter>().replace(NewGuestbookEntryRoute(picture: picture));
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      direction: widget.direction,
      children: controls(),
    );
  }

  List<Widget> controls() {
    late final Axis expandingDirection;
    switch (widget.direction) {
      case Axis.vertical:
        expandingDirection = Axis.horizontal;
      case Axis.horizontal:
        expandingDirection = Axis.vertical;
    }
    return [
      if (kIsWeb)
        const SizedBox()
      else
        FlashSelector(expandingDirection: expandingDirection),
      FloatingActionButton(
        onPressed: takePicture,
        child: const Icon(Icons.camera_alt),
      ),
      if (widget.cameraList.length < 2)
        const SizedBox()
      else
        CameraSelector(
          controller: widget.cameraDescriptionController,
          cameras: widget.cameraList,
          expandingDirection: expandingDirection,
        ),
    ];
  }
}
