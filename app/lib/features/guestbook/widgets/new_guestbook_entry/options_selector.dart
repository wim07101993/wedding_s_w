import 'package:flutter/material.dart';

class OptionsSelector<T> extends StatefulWidget {
  const OptionsSelector({
    super.key,
    required this.controller,
    required this.expandingDirection,
    required this.options,
    required this.optionBuilder,
    this.buttonContentBuilder,
  });

  final ValueNotifier<T> controller;
  final Axis expandingDirection;
  final List<T> options;
  final Widget Function(BuildContext context, T option) optionBuilder;
  final Widget Function(BuildContext context, T option)? buttonContentBuilder;

  @override
  State<OptionsSelector<T>> createState() => _OptionsSelectorState<T>();
}

class _OptionsSelectorState<T> extends State<OptionsSelector<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onOptionPressed(T option) {
    widget.controller.value = option;
    if (_animationController.value == 1) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<T>(
      valueListenable: widget.controller,
      builder: (context, currentValue, _) => Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: widget.expandingDirection,
          children: [
            _options(theme),
            IconButton(
              onPressed: () => onOptionPressed(currentValue),
              color: theme.primaryColor,
              icon: (widget.buttonContentBuilder ?? widget.optionBuilder)
                  .call(context, currentValue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _options(ThemeData theme) {
    return SizeTransition(
      axis: widget.expandingDirection,
      sizeFactor: _animation,
      child: ClipRect(
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          direction: widget.expandingDirection,
          children: <Widget>[
            for (final option in widget.options)
              IconButton(
                icon: widget.optionBuilder(context, option),
                color: widget.controller.value == option
                    ? theme.primaryColor
                    : null,
                onPressed: () {
                  widget.controller.value = option;
                  _animationController.reverse();
                },
              )
          ],
        ),
      ),
    );
  }
}
