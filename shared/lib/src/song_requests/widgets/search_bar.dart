import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:shared/src/dependency_management/get_it_provider.dart';
import 'package:shared/src/song_requests/behaviours/request_song.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/widgets/add_song_request_button.dart';
import 'package:shared/src/song_requests/widgets/search_text_field.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.onSongRequested,
  });

  final void Function(SongRequest songRequest) onSongRequested;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final RequestSong _requestSong = getIt();
  TextEditingController? searchController;

  void requestFreeInputSong() {
    final input = searchController?.text;
    if (input == null || input.isEmpty) {
      return;
    }
    requestSong(SongRequest.freeInput(input: input));
  }

  void requestSong(SongRequest song) {
    _requestSong(song).thenWhen(
      (exception) {
        if (exception is SongAlreadyRequestedException) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Het lied staat al in de lijst')),
          );
        }
      },
      (_) => widget.onSongRequested(song),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SearchTextField(
            onControllerChanged: (controller) => searchController = controller,
            onSelectSong: requestSong,
          ),
        ),
        const SizedBox(width: 4),
        AddSongRequestButton(onTap: requestFreeInputSong),
      ],
    );
  }
}
