import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/locations/widgets/location_tile.dart';
import 'package:wedding_s_w/shared/maps_launcher.dart';
import 'package:wedding_s_w/shared/resources/images.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locates')),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          LocationTile(
            onTap: () => launchCoordinates(51.0242402, 5.314006),
            title: const Text('Gemeentehuis'),
            child: const Image(image: Images.townHall, fit: BoxFit.cover),
          ),
          LocationTile(
            onTap: () => launchCoordinates(51.0119124, 5.2819679),
            title: const Text('Kerk'),
            child: const Image(image: Images.church, fit: BoxFit.cover),
          ),
          LocationTile(
            onTap: () => launchCoordinates(50.988404, 5.2771163),
            title: const Text('Witte Zaal'),
            child: const Image(image: Images.witteZaal, fit: BoxFit.cover),
          ),
          LocationTile(
            onTap: () => launchCoordinates(50.9969162, 5.2507218),
            title: const Text('Thuis'),
            child: const Image(image: Images.home, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
