import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/song_requests/behaviours/request_song.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/features/song_requests/widgets/add_song_request_button.dart';
import 'package:wedding_s_w/features/song_requests/widgets/search_field.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';

@RoutePage()
class SongRequestsScreen extends StatefulWidget {
  const SongRequestsScreen({super.key});

  @override
  State<SongRequestsScreen> createState() => _SongRequestsScreenState();
}

class _SongRequestsScreenState extends State<SongRequestsScreen> {
  late final requestSong = getIt<RequestSong>();
  TextEditingController? searchController;

  Future<void> requestFreeInputSong() {
    final input = searchController?.text;
    if (input == null || input.isEmpty) {
      return Future.value();
    }
    return requestSong(SongRequest.freeInput(input: input));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aangevraagde liedjes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _searchBar(),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        SearchField(
          onControllerChanged: (controller) => searchController = controller,
          onSelectSong: requestSong.call,
        ),
        const SizedBox(width: 4),
        AddSongRequestButton(onTap: requestFreeInputSong)
      ],
    );
  }
}
