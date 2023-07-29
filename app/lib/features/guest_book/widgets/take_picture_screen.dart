import 'package:auto_route/annotations.dart';
import 'package:behaviour/behaviour.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/camera_selector.dart';
import 'package:wedding_s_w/features/guest_book/widgets/flash_selector.dart';
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

  Future<void> takePicture() async {
    final picture = await getIt<TakePicture>()(cameraController).thenWhen(
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CloseButton(color: Colors.grey),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_cameraPreview()],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (kIsWeb) const SizedBox() else const FlashSelector(),
                  _cameraShutter(theme),
                  if (cameraDescriptionController.value == null ||
                      cameraList.length < 2)
                    const SizedBox()
                  else
                    CameraSelector(
                      controller: cameraDescriptionController,
                      cameras: cameraList,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cameraPreview() {
    final controller = cameraController;
    if (controller != null) {
      return CameraPreview(controller);
    }
    return const Text('NO CAMERA');
  }

  Widget _cameraShutter(ThemeData theme) {
    return FloatingActionButton(
      onPressed: takePicture,
      child: const Icon(Icons.camera_alt),
    );
  }
}
