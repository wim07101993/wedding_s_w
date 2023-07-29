import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/features/routing/app_router.dart';
import 'package:wedding_s_w/shared/dependency_management/feature.dart';

class RoutingFeature extends Feature {
  const RoutingFeature();

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerLazySingleton(() => AppRouter());
  }

  @override
  String toString() => 'routing feature';
}
