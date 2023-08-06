import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
    final controller = getIt<SongRequestPagingController>();
    return RefreshIndicator(
      onRefresh: () => Future.sync(controller.refresh),
      child: PagedListView<DateTime?, SongRequest>(
        pagingController: controller,
        padding: EdgeInsets.zero,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: _noItemsFoundIndicator,
          itemBuilder: widget.itemBuilder ?? _buildItem,
        ),
      ),
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
