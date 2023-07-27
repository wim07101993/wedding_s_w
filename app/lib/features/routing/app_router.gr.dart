// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/foundation.dart' as _i13;
import 'package:flutter/material.dart' as _i12;
import 'package:image_picker/image_picker.dart' as _i14;
import 'package:wedding_s_w/features/guest_book/models/guestbook_entry.dart'
    as _i11;
import 'package:wedding_s_w/features/guest_book/widgets/geustbook_entry_detail_screen.dart'
    as _i3;
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart'
    as _i6;
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart'
    as _i4;
import 'package:wedding_s_w/features/guest_book/widgets/take_picture_screen.dart'
    as _i5;
import 'package:wedding_s_w/features/home/widgets/home_screen.dart' as _i7;
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart'
    as _i9;
import 'package:wedding_s_w/features/locations/widgets/location_screen.dart'
    as _i2;
import 'package:wedding_s_w/features/quiz/widgets/quiz_screen.dart' as _i8;
import 'package:wedding_s_w/features/song_requests/widgets/song_requests_screen.dart'
    as _i1;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SongRequestsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SongRequestsScreen(),
      );
    },
    LocationsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LocationsScreen(),
      );
    },
    GuestbookEntryDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GuestbookEntryDetailRouteArgs>(
          orElse: () => GuestbookEntryDetailRouteArgs(
              guestbookEntryId: pathParams.getString('guestbookEntryId')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GuestbookEntryDetailScreen(
          key: args.key,
          guestbookEntryId: args.guestbookEntryId,
        ),
      );
    },
    NewGuestbookEntryRoute.name: (routeData) {
      final args = routeData.argsAs<NewGuestbookEntryRouteArgs>();
      return _i10.AutoRoutePage<_i11.GuestbookEntry?>(
        routeData: routeData,
        child: _i4.NewGuestbookEntryScreen(
          key: args.key,
          picture: args.picture,
        ),
      );
    },
    TakePictureRoute.name: (routeData) {
      return _i10.AutoRoutePage<_i11.GuestbookEntry?>(
        routeData: routeData,
        child: const _i5.TakePictureScreen(),
      );
    },
    GuestbookRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.GuestbookScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeScreen(),
      );
    },
    QuizRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.QuizScreen(),
      );
    },
    InvitationRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.InvitationScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.SongRequestsScreen]
class SongRequestsRoute extends _i10.PageRouteInfo<void> {
  const SongRequestsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SongRequestsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SongRequestsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LocationsScreen]
class LocationsRoute extends _i10.PageRouteInfo<void> {
  const LocationsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LocationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocationsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GuestbookEntryDetailScreen]
class GuestbookEntryDetailRoute
    extends _i10.PageRouteInfo<GuestbookEntryDetailRouteArgs> {
  GuestbookEntryDetailRoute({
    _i12.Key? key,
    required String guestbookEntryId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          GuestbookEntryDetailRoute.name,
          args: GuestbookEntryDetailRouteArgs(
            key: key,
            guestbookEntryId: guestbookEntryId,
          ),
          rawPathParams: {'guestbookEntryId': guestbookEntryId},
          initialChildren: children,
        );

  static const String name = 'GuestbookEntryDetailRoute';

  static const _i10.PageInfo<GuestbookEntryDetailRouteArgs> page =
      _i10.PageInfo<GuestbookEntryDetailRouteArgs>(name);
}

class GuestbookEntryDetailRouteArgs {
  const GuestbookEntryDetailRouteArgs({
    this.key,
    required this.guestbookEntryId,
  });

  final _i12.Key? key;

  final String guestbookEntryId;

  @override
  String toString() {
    return 'GuestbookEntryDetailRouteArgs{key: $key, guestbookEntryId: $guestbookEntryId}';
  }
}

/// generated route for
/// [_i4.NewGuestbookEntryScreen]
class NewGuestbookEntryRoute
    extends _i10.PageRouteInfo<NewGuestbookEntryRouteArgs> {
  NewGuestbookEntryRoute({
    _i13.Key? key,
    required _i14.XFile picture,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          NewGuestbookEntryRoute.name,
          args: NewGuestbookEntryRouteArgs(
            key: key,
            picture: picture,
          ),
          initialChildren: children,
        );

  static const String name = 'NewGuestbookEntryRoute';

  static const _i10.PageInfo<NewGuestbookEntryRouteArgs> page =
      _i10.PageInfo<NewGuestbookEntryRouteArgs>(name);
}

class NewGuestbookEntryRouteArgs {
  const NewGuestbookEntryRouteArgs({
    this.key,
    required this.picture,
  });

  final _i13.Key? key;

  final _i14.XFile picture;

  @override
  String toString() {
    return 'NewGuestbookEntryRouteArgs{key: $key, picture: $picture}';
  }
}

/// generated route for
/// [_i5.TakePictureScreen]
class TakePictureRoute extends _i10.PageRouteInfo<void> {
  const TakePictureRoute({List<_i10.PageRouteInfo>? children})
      : super(
          TakePictureRoute.name,
          initialChildren: children,
        );

  static const String name = 'TakePictureRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.GuestbookScreen]
class GuestbookRoute extends _i10.PageRouteInfo<void> {
  const GuestbookRoute({List<_i10.PageRouteInfo>? children})
      : super(
          GuestbookRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuestbookRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.QuizScreen]
class QuizRoute extends _i10.PageRouteInfo<void> {
  const QuizRoute({List<_i10.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.InvitationScreen]
class InvitationRoute extends _i10.PageRouteInfo<void> {
  const InvitationRoute({List<_i10.PageRouteInfo>? children})
      : super(
          InvitationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvitationRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
