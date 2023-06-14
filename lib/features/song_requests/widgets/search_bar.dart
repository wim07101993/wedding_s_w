import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/features/song_requests/widgets/add_song_request_button.dart';
import 'package:wedding_s_w/features/song_requests/widgets/search_text_field.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.onRequestSong,
  });

  final void Function(SongRequest songRequest) onRequestSong;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController? searchController;

  void requestFreeInputSong() {
    final input = searchController?.text;
    if (input == null || input.isEmpty) {
      return;
    }
    widget.onRequestSong(SongRequest.freeInput(input: input));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchTextField(
            onControllerChanged: (controller) => searchController = controller,
            onSelectSong: widget.onRequestSong,
          ),
        ),
        const SizedBox(width: 4),
        AddSongRequestButton(onTap: requestFreeInputSong),
      ],
    );
  }
}
