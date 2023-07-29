import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';

class CameraSelector extends StatefulWidget {
  const CameraSelector({
    super.key,
    required this.controller,
    required this.cameras,
  });

  final CameraDescriptionController controller;
  final CameraList cameras;

  @override
  State<CameraSelector> createState() => _CameraSelectorState();
}

class _CameraSelectorState extends State<CameraSelector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flashModeControlRowAnimationController;
  late final Animation<double> _flashModeControlRowAnimation;

  @override
  void initState() {
    super.initState();
    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flashModeControlRowAnimation = CurvedAnimation(
      parent: _flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _flashModeControlRowAnimationController.dispose();
    super.dispose();
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<CameraDescription?>(
      valueListenable: widget.controller,
      builder: (context, currentCamera, _) => Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cameraOptions(theme),
            IconButton(
              onPressed: onFlashModeButtonPressed,
              color: theme.primaryColor,
              icon: currentCamera == null
                  ? const Icon(Icons.camera)
                  : Icon(currentCamera.lensDirection.icon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cameraOptions(ThemeData theme) {
    final currentCamera = widget.controller.value;
    return SizeTransition(
      sizeFactor: _flashModeControlRowAnimation,
      child: ClipRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final cameraDescription in widget.cameras)
              IconButton(
                icon: camera(cameraDescription),
                color: currentCamera == cameraDescription
                    ? theme.primaryColor
                    : null,
                onPressed: () {
                  widget.controller.value = cameraDescription;
                  _flashModeControlRowAnimationController.reverse();
                },
              )
          ],
        ),
      ),
    );
  }

  Widget camera(CameraDescription camera) {
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
