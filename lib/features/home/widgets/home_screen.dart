import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart';
import 'package:wedding_s_w/features/home/widgets/navigation_tile.dart';
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart';
import 'package:wedding_s_w/features/locations/widgets/location_screen.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';
import 'package:wedding_s_w/shared/dependency_management/global_value_builder.dart';
import 'package:wedding_s_w/shared/firebase/remote_config_global_value.dart';
import 'package:wedding_s_w/shared/resources/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
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
            builder: (context, config) {
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  if (config.featureFlags.shouldGuestbookBeVisible)
                    NavigationTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GuestbookScreen(),
                          ),
                        );
                      },
                      title: const Text('gastenboek'),
                      child: const Image(
                        image: Images.guestbookTile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  NavigationTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const InvitationScreen(),
                        ),
                      );
                    },
                    title: const Text('Uitnodiging bekijken'),
                    child: const Image(
                      image: Images.invitationTile,
                      fit: BoxFit.cover,
                    ),
                  ),
                  NavigationTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LocationsScreen(),
                        ),
                      );
                    },
                    title: const Text('Locaties'),
                    child: const Image(image: Images.map, fit: BoxFit.cover),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
