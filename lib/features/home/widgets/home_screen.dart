import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/home/widgets/tiles/dj_suggestions_tile.dart';
import 'package:wedding_s_w/features/home/widgets/tiles/guestbook_tile.dart';
import 'package:wedding_s_w/features/home/widgets/tiles/invitation_tile.dart';
import 'package:wedding_s_w/features/home/widgets/tiles/location_tile.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';
import 'package:wedding_s_w/shared/dependency_management/global_value_builder.dart';
import 'package:wedding_s_w/shared/firebase/remote_config_global_value.dart';
import 'package:wedding_s_w/shared/resources/images.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(image: Images.homeHeader),
            Text(
              'TROUW',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            Text(
              'Sara & Wim',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge,
            ),
            GlobalValueBuilder(
              globalValue: getIt(context).get<RemoteConfigGlobalValue>(),
              builder: (context, config) => GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  if (config.featureFlags.shouldGuestbookBeVisible)
                    const GuestbookTile(),
                  const InvitationTile(),
                  const LocationTile(),
                  const DjSuggestionsTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
