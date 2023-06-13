import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/home/widgets/tiles/navigation_tile.dart';
import 'package:wedding_s_w/features/routing/app_router.gr.dart';
import 'package:wedding_s_w/shared/resources/images.dart';

class DjSuggestionsTile extends StatelessWidget {
  const DjSuggestionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationTile(
      onTap: () => AutoRouter.of(context).push(const SongRequestsRoute()),
      title: const Text('Liedje aanvragen'),
      child: const Image(
        image: Images.dj,
        fit: BoxFit.cover,
      ),
    );
  }
}
