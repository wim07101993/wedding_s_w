import 'package:admin_app/shared/dependency_management/global_value.dart';
import 'package:flutter/material.dart';

class GlobalValueBuilder<T> extends StatefulWidget {
  const GlobalValueBuilder({
    super.key,
    required this.globalValue,
    required this.builder,
  });

  final ReadOnlyGlobalValue<T> globalValue;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<GlobalValueBuilder<T>> createState() => _GlobalValueBuilderState();
}

class _GlobalValueBuilderState<T> extends State<GlobalValueBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.globalValue.changes,
      builder: (context, snapshot) => widget.builder(
        context,
        widget.globalValue.value,
      ),
    );
  }
}
