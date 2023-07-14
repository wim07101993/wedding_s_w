import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  const NavigationTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onTap,
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black38,
            title: title,
          ),
          child: child,
        ),
      ),
    );
  }
}
