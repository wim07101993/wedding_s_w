import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart' hide CameraPreview;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/CameraPreview.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/camera_controls.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

@RoutePage<GuestbookEntry?>()
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
  });

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final cameraDescriptionController = CameraDescriptionController(null);
  final CameraList cameraList = [];

  late final flashController = getIt<FlashController>();

  bool hasLoadedCamera = false;

  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cameraDescriptionController
        .addListener(updateCameraDescriptionOfController);
    availableCameras().then(
      (cameras) {
        cameraList.addAll(cameras);
        selectDefaultCamera();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!kIsWeb) {
      flashController.addListener(onFlashModeChanged);
    }
  }

  void selectDefaultCamera() {
    final cameras = cameraList;
    final camera = cameras.firstOrNull;
    if (camera == null || cameraDescriptionController.value != null) {
      return;
    }
    cameraDescriptionController.value = camera;
  }

  void updateCameraDescriptionOfController() {
    final cameraDescription = cameraDescriptionController.value;
    final cameraController = this.cameraController;
    if (cameraController == null && cameraDescription == null) {
      return;
    }
    if (cameraController != null && cameraDescription != null) {
      cameraController.setDescription(cameraDescription);
      setState(() {});
      return;
    }
    if (cameraDescription != null) {
      initCameraController(cameraDescription);
      return;
    }
  }

  Future<void> initCameraController(CameraDescription camera) async {
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller.initialize();
    if (!kIsWeb) {
      controller.setFlashMode(flashController.value);
      controller.unlockCaptureOrientation();
    }
    setState(() => cameraController = controller);
  }

  void onFlashModeChanged() {
    final cameraController = this.cameraController;
    if (!kIsWeb && cameraController != null) {
      cameraController.setFlashMode(flashController.value);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = this.cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      cameraDescriptionController.value = cameraController.description;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraDescriptionController
        .removeListener(updateCameraDescriptionOfController);
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = this.cameraController;
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) => Stack(
          children: [
            if (cameraController != null) ...[
              cameraBody(cameraController, orientation),
              cameraControls(cameraController, orientation),
            ] else
              const Text('NO CAMERA'),
            closeButton(orientation),
          ],
        ),
      ),
    );
  }

  Widget closeButton(Orientation orientation) {
    late final Alignment alignment;
    switch (orientation) {
      case Orientation.landscape:
        alignment = Alignment.topLeft;
      case Orientation.portrait:
        alignment = Alignment.topRight;
    }
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CloseButton(
            color: Colors.grey,
            onPressed: () {
              final router = getIt<AppRouter>();
              if (router.canPop()) {
                router.pop();
              } else {
                router.replace(const GuestbookRoute());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget cameraBody(CameraController controller, Orientation orientation) {
    late final Axis direction;
    switch (orientation) {
      case Orientation.landscape:
        direction = Axis.horizontal;
      case Orientation.portrait:
        direction = Axis.vertical;
    }
    return Flex(
      direction: direction,
      children: [
        Center(
          child: CameraPreview(controller: controller),
        ),
      ],
    );
  }

  Widget cameraControls(
    CameraController cameraController,
    Orientation orientation,
  ) {
    late final Axis direction;
    late final Alignment alignment;
    late final EdgeInsets padding;
    switch (orientation) {
      case Orientation.landscape:
        direction = Axis.vertical;
        alignment = Alignment.centerRight;
        padding = const EdgeInsets.only(right: 32);
      case Orientation.portrait:
        direction = Axis.horizontal;
        alignment = Alignment.bottomCenter;
        padding = const EdgeInsets.only(bottom: 32);
    }

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: CameraControls(
            cameraController: cameraController,
            cameraDescriptionController: cameraDescriptionController,
            cameraList: cameraList,
            direction: direction,
          ),
        ),
      ),
    );
  }
}
