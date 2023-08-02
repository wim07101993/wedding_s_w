import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/src/dependency_management/get_it_provider.dart';
import 'package:shared/src/song_requests/behaviours/get_song_requests.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/free_input_song_request_list_item.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/no_songs_requested_indicator.dart';
import 'package:shared/src/song_requests/widgets/song_request_list/spotify_song_request_list_item.dart';

class SongRequestList extends StatefulWidget {
  const SongRequestList({
    super.key,
    required this.controller,
  });

  final PagingController<DateTime?, SongRequest> controller;

  @override
  State<SongRequestList> createState() => _SongRequestListState();
}

class _SongRequestListState extends State<SongRequestList> {
  late final getSongRequests = getIt<GetSongRequests>();

  @override
  void initState() {
    super.initState();
    widget.controller.addPageRequestListener(fetchPage);
  }

  @override
  void didUpdateWidget(SongRequestList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removePageRequestListener(fetchPage);
      widget.controller.addPageRequestListener(fetchPage);
    }
  }

  Future<void> fetchPage(DateTime? lastRequestTimestamp) async {
    final response = await getSongRequests(
      GetSongRequestsQuery(lastItemTime: lastRequestTimestamp),
    );
    if (!mounted) {
      return;
    }
    response.when(
      (exception) => widget.controller.error = exception,
      (value) {
        widget.controller.appendPage(
          value,
          value.lastOrNull?.timestamp,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(widget.controller.refresh),
      child: PagedListView<DateTime?, SongRequest>(
        pagingController: widget.controller,
        padding: EdgeInsets.zero,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: _noItemsFoundIndicator,
          itemBuilder: _buildItem,
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
