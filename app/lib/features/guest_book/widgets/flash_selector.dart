import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class FlashSelector extends StatefulWidget {
  const FlashSelector({super.key});

  @override
  State<FlashSelector> createState() => _FlashSelectorState();
}

class _FlashSelectorState extends State<FlashSelector>
    with SingleTickerProviderStateMixin {
  late final flashController = getIt<FlashController>();
  late final AnimationController _flashModeSelectionAnimationController;
  late final Animation<double> _flashModeSelectionAnimation;

  @override
  void initState() {
    super.initState();
    _flashModeSelectionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flashModeSelectionAnimation = CurvedAnimation(
      parent: _flashModeSelectionAnimationController,
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _flashModeSelectionAnimationController.dispose();
    super.dispose();
  }

  void onFlashModeButtonPressed() {
    if (_flashModeSelectionAnimationController.value == 1) {
      _flashModeSelectionAnimationController.reverse();
    } else {
      _flashModeSelectionAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<FlashMode>(
      valueListenable: flashController,
      builder: (context, flashMode, _) => Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _flashModeOptinos(theme),
            IconButton(
              onPressed: onFlashModeButtonPressed,
              color: theme.primaryColor,
              icon: Icon(flashMode.icon),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flashModeOptinos(ThemeData theme) {
    final currentMode = flashController.value;
    return SizeTransition(
      sizeFactor: _flashModeSelectionAnimation,
      child: ClipRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final flashMode
                in FlashMode.values.where((mode) => mode != currentMode))
              IconButton(
                icon: Icon(flashMode.icon),
                color: currentMode == flashMode ? theme.primaryColor : null,
                onPressed: () {
                  flashController.value = flashMode;
                  _flashModeSelectionAnimationController.reverse();
                },
              )
          ],
        ),
      ),
    );
  }
}

extension FlashModeExtensions on FlashMode {
  IconData get icon {
    switch (this) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.torch:
        return Icons.highlight;
    }
  }
}
