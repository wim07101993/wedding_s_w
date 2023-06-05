import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/guest_book/widgets/guestbook_screen.dart';
import 'package:wedding_s_w/features/guest_book/widgets/new_guestbook_entry_screen.dart';
import 'package:wedding_s_w/features/home/widgets/home_screen.dart';
import 'package:wedding_s_w/features/invitation/widgets/invitation_screen.dart';
import 'package:wedding_s_w/shared/routing.dart';
import 'package:wedding_s_w/shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trouw Sara & Wim',
      theme: appTheme,
      routes: {
        route<HomeScreen>(): (context) => HomeScreen(),
        route<GuestbookScreen>(): (context) => GuestbookScreen(),
        route<InvitationScreen>(): (context) => InvitationScreen(),
        route<NewGuestbookEntryScreen>(): (context) =>
            NewGuestbookEntryScreen(),
      },
      initialRoute: route<HomeScreen>(),
    );
  }
}
