import 'package:admin_app/features/routing/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/dependency_management/feature.dart';

class RoutingFeature extends Feature {
  const RoutingFeature();

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerLazySingleton(() => AppRouter());
  }
}
