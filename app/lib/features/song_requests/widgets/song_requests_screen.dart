import 'package:flutter/material.dart' hide SearchBar;
import 'package:shared/resources/fonts.dart';
import 'package:shared/song_requests.dart';

class SongRequestsScreen extends StatefulWidget {
  const SongRequestsScreen({super.key});

  @override
  State<SongRequestsScreen> createState() => _SongRequestsScreenState();
}

class _SongRequestsScreenState extends State<SongRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Wil je een liedje aanvragen?',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const SearchBar(),
                const SizedBox(height: 24),
                const Text(
                  'Aangevraagde liedjes',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: Fonts.centuryGothic,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(child: SongRequestList()),
        ],
      ),
    );
  }
}
