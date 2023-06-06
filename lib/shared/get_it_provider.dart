import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GetItProvider extends InheritedWidget {
  const GetItProvider({
    super.key,
    required this.getIt,
    required super.child,
  });

  final GetIt getIt;

  @override
  bool updateShouldNotify(covariant GetItProvider oldWidget) {
    return oldWidget.getIt != getIt;
  }

  static GetItProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GetItProvider>();
  }

  static GetItProvider of(BuildContext context) {
    final getItProvider = maybeOf(context);
    assert(getItProvider != null, 'No GetItProvider found in context');
    return getItProvider!;
  }
}

extension StateExtensions<T extends StatefulWidget> on State<T> {
  GetIt get getIt => GetItProvider.of(context).getIt;
}
