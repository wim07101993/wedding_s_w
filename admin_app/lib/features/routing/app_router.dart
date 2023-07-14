import 'package:admin_app/features/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: HomeRoute.page, initial: true),
      AutoRoute(page: GuestbookRoute.page, path: '/guestbook'),
      AutoRoute(page: SongRequestsRoute.page, path: '/song-requests'),
    ];
  }
}
