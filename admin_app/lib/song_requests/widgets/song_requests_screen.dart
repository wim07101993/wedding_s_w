import 'package:admin_app/song_requests/widgets/free_input_song_request_list_item.dart';
import 'package:admin_app/song_requests/widgets/spotify_song_request_list_item.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/resources/fonts.dart';
import 'package:shared/resources/images.dart';
import 'package:shared/song_requests.dart';

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
        Expanded(child: SongRequestList(itemBuilder: _buildItem)),
      ],
    );
  }

  Widget _buildItem(BuildContext context, SongRequest songRequest, int index) {
    final songListTile = songRequest.when(
      freeInputSongRequest: (song) => FreeInputSongRequestListItem(
        song: song,
      ),
      spotifySong: (song) => SpotifySongRequestListItem(song: song),
    );

    if (index == 0) {
      return songListTile;
    } else {
      return Column(
        children: [
          const Divider(),
          songListTile,
        ],
      );
    }
  }
}
