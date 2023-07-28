import 'package:auto_route/auto_route.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: HomeRoute.page, initial: true),
      AutoRoute(page: InvitationRoute.page, path: '/invitation'),
      AutoRoute(page: LocationsRoute.page, path: '/locations'),
      AutoRoute(page: GuestbookRoute.page, path: '/guestbook'),
      AutoRoute(
        page: GuestbookEntryDetailRoute.page,
        path: '/guestbook/:guestbookEntryId',
      ),
      AutoRoute(page: NewGuestbookEntryRoute.page, path: '/guestbook/new'),
      AutoRoute(page: TakePictureRoute.page, path: '/guestbook/new/picture'),
      AutoRoute(page: SongRequestsRoute.page, path: '/song-requests'),
    ];
  }
}
