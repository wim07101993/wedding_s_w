import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/options_selector.dart';

class CameraSelector extends StatefulWidget {
  const CameraSelector({
    super.key,
    required this.controller,
    required this.cameras,
    required this.expandingDirection,
  });

  final CameraDescriptionController controller;
  final CameraList cameras;
  final Axis expandingDirection;

  @override
  State<CameraSelector> createState() => _CameraSelectorState();
}

class _CameraSelectorState extends State<CameraSelector>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CameraDescription?>(
      valueListenable: widget.controller,
      builder: (context, currentCamera, _) => OptionsSelector(
        controller: widget.controller,
        expandingDirection: widget.expandingDirection,
        options: widget.cameras,
        buttonContentBuilder: (context, camera) => camera == null
            ? const Icon(Icons.camera)
            : Icon(camera.lensDirection.icon),
        optionBuilder: (context, camera) =>
            camera == null ? const Icon(Icons.camera) : _camera(camera),
      ),
    );
  }

  Widget _camera(CameraDescription camera) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(camera.lensDirection.icon),
        Text(camera.name),
      ],
    );
  }
}

extension CameraLensDirectionExtensions on CameraLensDirection {
  IconData get icon {
    switch (this) {
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
}
