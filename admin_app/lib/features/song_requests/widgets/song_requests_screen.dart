import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/song_requests/models/song_request.dart';
import 'package:shared/song_requests/widgets/search_bar.dart';
import 'package:shared/song_requests/widgets/song_request_list/song_request_list.dart';

@RoutePage()
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
    return Scaffold(
      appBar: AppBar(title: const Text('Aangevraagde liedjes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(onSongRequested: onRequestSong),
          ),
          Expanded(child: SongRequestList(controller: pagingController)),
        ],
      ),
    );
  }
}
