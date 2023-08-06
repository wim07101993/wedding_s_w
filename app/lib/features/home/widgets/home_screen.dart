import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared/song_requests.dart';
import 'package:wedding_s_w/features/guestbook/widgets/guestbook_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const animationDuration = Duration(milliseconds: 500);
  final carouselController = CarouselController();
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            AnimatedPositioned(
              duration: animationDuration,
              left: position == 0 ? 0 : -constraints.maxWidth - 1,
              child: ConstrainedBox(
                constraints: constraints,
                child: const GuestbookScreen(),
              ),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              left: position == 1 ? 0 : constraints.maxWidth + 1,
              child: ConstrainedBox(
                constraints: constraints,
                child: const SongRequestsScreen(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
  }
}
