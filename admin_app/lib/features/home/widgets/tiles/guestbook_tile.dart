import 'package:admin_app/features/home/widgets/tiles/navigation_tile.dart';
import 'package:admin_app/features/routing/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/resources/images.dart';

class GuestbookTile extends StatelessWidget {
  const GuestbookTile({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationTile(
      onTap: () => AutoRouter.of(context).push(const GuestbookRoute()),
      title: const Text('gastenboek'),
      child: const Image(
        image: Images.guestbookTile,
        fit: BoxFit.cover,
      ),
    );
  }
}
