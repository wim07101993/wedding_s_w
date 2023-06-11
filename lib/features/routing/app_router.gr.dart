// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart'
    as _i3;
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart'
    as _i2;
import 'package:wedding_s_w/features/home/widgets/home_screen.dart' as _i4;
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart'
    as _i5;
import 'package:wedding_s_w/features/locations/widgets/location_screen.dart'
    as _i1;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    LocationsRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LocationsScreen(),
      );
    },
    NewGuestbookEntryRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NewGuestbookEntryScreen(),
      );
    },
    GuestbookRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GuestbookScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    InvitationRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.InvitationScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.LocationsScreen]
class LocationsRoute extends _i6.PageRouteInfo<void> {
  const LocationsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationsRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NewGuestbookEntryScreen]
class NewGuestbookEntryRoute extends _i6.PageRouteInfo<void> {
  const NewGuestbookEntryRoute({List<_i6.PageRouteInfo>? children})
      : super(
          NewGuestbookEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewGuestbookEntryRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GuestbookScreen]
class GuestbookRoute extends _i6.PageRouteInfo<void> {
  const GuestbookRoute({List<_i6.PageRouteInfo>? children})
      : super(
          GuestbookRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuestbookRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.InvitationScreen]
class InvitationRoute extends _i6.PageRouteInfo<void> {
  const InvitationRoute({List<_i6.PageRouteInfo>? children})
      : super(
          InvitationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvitationRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
