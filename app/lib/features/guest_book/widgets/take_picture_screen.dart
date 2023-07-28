import 'package:auto_route/annotations.dart';
import 'package:behaviour/behaviour.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/behaviours/take_picture.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart';
import 'package:wedding_s_w/features/guest_book/widgets/camera_dialog_content.dart';
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
  late final flashController = getIt<FlashController>();
  final CameraList cameraList = [];

  bool hasLoadedCamera = false;

  set selectedCamera(CameraDescription? value) {
    final cameraController = this.cameraController;
    if (cameraController == null && value == null) {
      return;
    }
    if (cameraController != null && value != null) {
      cameraController.setDescription(value);
      setState(() {});
      return;
    }
    if (value != null) {
      initCameraController(value);
      return;
    }
  }

  CameraDescription? get selectedCamera => cameraController?.description;

  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    flashController.addListener(onFlashModeChanged);
  }

  void selectDefaultCamera() {
    final cameras = cameraList;
    final camera = cameras.firstOrNull;
    if (camera == null || selectedCamera != null) {
      return;
    }
    selectedCamera = camera;
  }

  Future<void> initCameraController(CameraDescription camera) async {
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller.initialize();
    controller.setFlashMode(flashController.value);
    setState(() => cameraController = controller);
  }

  void onFlashModeChanged() {
    final cameraController = this.cameraController;
    if (cameraController != null) {
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
      selectedCamera = cameraController.description;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
                  if (!kIsWeb) const FlashSelector() else const SizedBox(),
                  _cameraShutter(theme),
                  _cameraSelector(theme),
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

  Widget _cameraSelector(ThemeData theme) {
    final cameraList = this.cameraList;
    final camera = selectedCamera;
    if (camera == null || cameraList.length < 2) {
      return Container();
    }
    return IconButton(
      onPressed: openCameraDialog,
      color: theme.primaryColor,
      icon: Icon(getCameraLensIcon(camera.lensDirection)),
    );
  }

  Future<void> openCameraDialog() async {
    selectedCamera = await showDialog<CameraDescription?>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: CameraDialogContent(cameraList: cameraList),
        ),
      ),
    );
  }
}
