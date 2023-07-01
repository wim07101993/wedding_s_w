// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart'
    as _i3;
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart'
    as _i2;
import 'package:wedding_s_w/features/home/widgets/home_screen.dart' as _i4;
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart'
    as _i5;
import 'package:wedding_s_w/features/locations/widgets/location_screen.dart'
    as _i1;
import 'package:wedding_s_w/features/quiz/widgets/quiz_screen.dart' as _i7;
import 'package:wedding_s_w/features/song_requests/widgets/song_requests_screen.dart'
    as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    LocationsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LocationsScreen(),
      );
    },
    NewGuestbookEntryRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NewGuestbookEntryScreen(),
      );
    },
    GuestbookRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GuestbookScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeScreen(),
      );
    },
    InvitationRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.InvitationScreen(),
      );
    },
    SongRequestsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SongRequestsScreen(),
      );
    },
    QuizRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.QuizScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.LocationsScreen]
class LocationsRoute extends _i8.PageRouteInfo<void> {
  const LocationsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NewGuestbookEntryScreen]
class NewGuestbookEntryRoute extends _i8.PageRouteInfo<void> {
  const NewGuestbookEntryRoute({List<_i8.PageRouteInfo>? children})
      : super(
          NewGuestbookEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewGuestbookEntryRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GuestbookScreen]
class GuestbookRoute extends _i8.PageRouteInfo<void> {
  const GuestbookRoute({List<_i8.PageRouteInfo>? children})
      : super(
          GuestbookRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuestbookRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.InvitationScreen]
class InvitationRoute extends _i8.PageRouteInfo<void> {
  const InvitationRoute({List<_i8.PageRouteInfo>? children})
      : super(
          InvitationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvitationRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SongRequestsScreen]
class SongRequestsRoute extends _i8.PageRouteInfo<void> {
  const SongRequestsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SongRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SongRequestsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.QuizScreen]
class QuizRoute extends _i8.PageRouteInfo<void> {
  const QuizRoute({List<_i8.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
