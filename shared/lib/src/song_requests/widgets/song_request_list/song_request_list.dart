import 'package:flutter/material.dart';
import 'package:shared/src/dependency_management/get_it_provider.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/shared_song_requests_feature.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/free_input_song_request_list_item.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/no_songs_requested_indicator.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/spotify_song_request_list_item.dart';

class SongRequestList extends StatefulWidget {
  const SongRequestList({
    super.key,
    this.itemBuilder,
  });

  final Widget Function(
    BuildContext context,
    SongRequest songRequest,
    int index,
  )? itemBuilder;

  @override
  State<SongRequestList> createState() => _SongRequestListState();
}

class _SongRequestListState extends State<SongRequestList> {
  @override
  Widget build(BuildContext context) {
    final controller = getIt<SongRequestController>();
    return ValueListenableBuilder<List<SongRequest>>(
      valueListenable: controller,
      builder: (context, items, _) {
        if (items.isEmpty) {
          return _noItemsFoundIndicator(context);
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) => (widget.itemBuilder ?? _buildItem)(
            context,
            controller.value[index],
            index,
          ),
        );
      },
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

  Widget _noItemsFoundIndicator(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: NoSongsRequestedIndicator(),
    );
  }
}
