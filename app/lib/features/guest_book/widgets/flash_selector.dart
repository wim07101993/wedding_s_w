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

  IconData getIconForFlashMode(FlashMode flashMode) {
    switch (flashMode) {
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
            _flashModeControlOptions(theme),
            IconButton(
              onPressed: onFlashModeButtonPressed,
              color: theme.primaryColor,
              icon: Icon(getIconForFlashMode(flashMode)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flashModeControlOptions(ThemeData theme) {
    final currentMode = flashController.value;
    return SizeTransition(
      sizeFactor: _flashModeControlRowAnimation,
      child: ClipRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final flashMode in FlashMode.values
                .where((value) => value != flashController.value))
              IconButton(
                icon: Icon(getIconForFlashMode(flashMode)),
                color: currentMode == flashMode ? theme.primaryColor : null,
                onPressed: () {
                  flashController.value = flashMode;
                  _flashModeControlRowAnimationController.reverse();
                },
              )
          ],
        ),
      ),
    );
  }
}
