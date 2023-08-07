import 'package:flutter/material.dart';
import 'package:shared/src/dependency_management/get_it_provider.dart';
import 'package:shared/src/song_requests/behaviours/request_song.dart';
import 'package:shared/src/song_requests/models/song_request.dart';
import 'package:shared/src/song_requests/widgets/add_song_request_button.dart';
import 'package:shared/src/song_requests/widgets/search_text_field.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final RequestSong _requestSong = getIt();

  bool isRequesting = false;
  TextEditingController? searchController;

  void requestFreeInputSong() {
    final input = searchController?.text;
    if (input == null || input.isEmpty) {
      return;
    }
    requestSong(SongRequest.freeInput(input: input));
  }

  Future<void> requestSong(SongRequest song) async {
    setState(() => isRequesting = true);
    try {
      final exceptionOr = await _requestSong(song);
      if (!mounted) {
        return;
      }
      exceptionOr.whenFailed((exception) {
        if (exception is SongAlreadyRequestedException) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Het lied staat al in de lijst')),
          );
        }
      });
    } finally {
      setState(() => isRequesting = false);
    }
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
        if (isRequesting)
          const CircularProgressIndicator()
        else
          AddSongRequestButton(onTap: requestFreeInputSong),
      ],
    );
  }
}
