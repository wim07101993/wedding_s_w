import 'package:flutter/material.dart';
import 'package:shared/resources/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.guestbook,
    required this.songRequests,
  });

  final Widget guestbook;
  final Widget songRequests;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const animationDuration = Duration(milliseconds: 100);
  int position = 0;

  Tween<Offset> songRequestPosition(BoxConstraints constraints) {
    final offscreen = Offset(-constraints.maxWidth - 1, 0);
    const onscreen = Offset.zero;
    return position == 0
        ? Tween(begin: offscreen, end: offscreen)
        : Tween(begin: onscreen, end: onscreen);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutNextToEachOther =
            constraints.maxHeight < constraints.maxWidth;
        return Scaffold(
          body: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => layoutNextToEachOther
                    ? buildLandscape(context, constraints)
                    : buildPortrait(context, constraints),
              ),
              const SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: Images.homeHeaderLeft),
                    Image(image: Images.homeHeaderRight),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: layoutNextToEachOther
              ? null
              : BottomNavigationBar(
                  onTap: (index) => setState(() => position = index),
                  currentIndex: position,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.photo_album),
                      label: 'gastenboek',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.music_note),
                      label: 'liedjes',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget buildPortrait(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: animationDuration,
          left: position == 0 ? 0 : -constraints.maxWidth - 1,
          child: ConstrainedBox(
            constraints: constraints,
            child: widget.guestbook,
          ),
        ),
        AnimatedPositioned(
          duration: animationDuration,
          left: position == 1 ? 0 : constraints.maxWidth + 1,
          child: ConstrainedBox(
            constraints: constraints,
            child: widget.songRequests,
          ),
        ),
      ],
    );
  }

  Widget buildLandscape(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: widget.guestbook),
          Expanded(child: widget.songRequests),
        ],
      ),
    );
  }
}
