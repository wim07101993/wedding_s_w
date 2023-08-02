import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/resources/fonts.dart';
import 'package:shared/resources/images.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/widgets/search_bar.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/song_request_list.dart';

class SongRequestsScreen extends StatefulWidget {
  const SongRequestsScreen({super.key});

  @override
  State<SongRequestsScreen> createState() => _SongRequestsScreenState();
}

class _SongRequestsScreenState extends State<SongRequestsScreen> {
  final pagingController = PagingController<DateTime?, SongRequest>(
    firstPageKey: null,
  );

  void onRequestSong(SongRequest songRequest) {
    pagingController.itemList = [
      songRequest,
      ...pagingController.itemList ?? [],
    ];
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Image(image: Images.homeHeader),
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
              SearchBar(onSongRequested: onRequestSong),
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
        Expanded(child: SongRequestList(controller: pagingController)),
      ],
    );
  }
}
