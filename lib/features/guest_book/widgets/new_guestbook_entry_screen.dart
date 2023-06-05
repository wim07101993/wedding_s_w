import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/widgets/loading_overlay.dart';

class NewGuestbookEntryScreen extends StatefulWidget {
  const NewGuestbookEntryScreen({super.key});

  @override
  State<NewGuestbookEntryScreen> createState() =>
      _NewGuestbookScreenEntryState();
}

class _NewGuestbookScreenEntryState extends State<NewGuestbookEntryScreen> {
  static final Future<List<CameraDescription>> _availableCameras =
      availableCameras();

  CameraController? cameraController;
  bool isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    initCameras();
  }

  Future<void> initCameras() async {
    final cameras = await _availableCameras;
    if (!mounted) {
      return;
    }

    if (cameras.isEmpty) {
      // TODO show error dialog
      return;
    }
    final camera = cameras
            .where((c) => c.lensDirection == CameraLensDirection.front)
            .firstOrNull ??
        cameras.first;

    final cameraController = CameraController(camera, ResolutionPreset.max);
    await cameraController.initialize();
    setState(() => this.cameraController = cameraController);
  }

  Future<void> takePicture() async {
    final cameraController = this.cameraController;
    if (cameraController == null) {
      return;
    }
    setState(() => isTakingPicture = true);
    final picture = await cameraController.takePicture();
    setState(() => isTakingPicture = false);
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = this.cameraController;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (cameraController != null)
            Center(child: CameraPreview(cameraController)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: orientation == Orientation.portrait
                  ? Alignment.bottomCenter
                  : Alignment.centerRight,
              child: IconButton.filled(
                onPressed: takePicture,
                icon: const Icon(Icons.camera, size: 42),
              ),
            ),
          ),
          if (cameraController == null) LoadingOverlay(label: 'camera laden'),
          if (isTakingPicture) LoadingOverlay(label: 'foto verwerken'),
        ],
      ),
    );
  }
}
