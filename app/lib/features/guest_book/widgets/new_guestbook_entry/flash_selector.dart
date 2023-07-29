import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/guest_book_feature.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry/options_selector.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

class FlashSelector extends StatelessWidget {
  const FlashSelector({
    super.key,
    required this.expandingDirection,
  });

  final Axis expandingDirection;

  @override
  Widget build(BuildContext context) {
    final flashController = getIt(context)<FlashController>();
    return ValueListenableBuilder<FlashMode>(
      valueListenable: flashController,
      builder: (context, flashMode, _) => OptionsSelector(
        controller: flashController,
        expandingDirection: expandingDirection,
        options: FlashMode.values
            .where((value) => value != flashMode)
            .toList(growable: false),
        optionBuilder: (context, option) => Icon(option.icon),
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
