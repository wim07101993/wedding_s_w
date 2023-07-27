import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class CameraDialogContent extends StatelessWidget {
  const CameraDialogContent({
    super.key,
    required this.cameraList,
  });

  final CameraList cameraList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Welke camera wil je gebruiken?'),
        const SizedBox(height: 8),
        for (final camera in cameraList) _cameraToggle(context, camera),
      ],
    );
  }

  Widget _cameraToggle(BuildContext context, CameraDescription camera) {
    return TextButton(
      onPressed: () => getIt(context).get<AppRouter>().pop(camera),
      child: Row(
        children: [
          Icon(getCameraLensIcon(camera.lensDirection)),
          const SizedBox(width: 8),
          Text(getCameraLensName(camera.lensDirection)),
        ],
      ),
    );
  }
}

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  // This enum is from a different package, so a new value could be added at
  // any time. The example should keep working if that happens.
  // ignore: dead_code
  return Icons.camera;
}

String getCameraLensName(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return 'Camera aan achterkant';
    case CameraLensDirection.front:
      return 'Selfie camera';
    case CameraLensDirection.external:
      return 'Externe camera';
  }
  // This enum is from a different package, so a new value could be added at
  // any time. The example should keep working if that happens.
  // ignore: dead_code
  return 'Camera';
}
