import 'package:camera/camera.dart';
import 'package:camera/camera.dart' as camera_package;
import 'package:flutter/material.dart';

class CameraPreview extends StatefulWidget {
  const CameraPreview({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  State<CameraPreview> createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  int _pointers = 0;

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    widget.controller.setExposurePoint(offset);
    widget.controller.setFocusPoint(offset);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (_pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await widget.controller.setZoomLevel(_currentScale);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pointers++,
      onPointerUp: (_) => _pointers--,
      child: camera_package.CameraPreview(
        widget.controller,
        child: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onScaleStart: _handleScaleStart,
            onScaleUpdate: _handleScaleUpdate,
            onTapDown: (details) => onViewFinderTap(details, constraints),
          ),
        ),
      ),
    );
  }
}
