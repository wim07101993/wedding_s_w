import 'package:flutter/material.dart';
import 'package:shared/song_requests/models/free_input_song_request.dart';

class FreeInputSongRequestListItem extends StatelessWidget {
  const FreeInputSongRequestListItem({
    super.key,
    required this.song,
  });

  final FreeInputSongRequest song;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: theme.cardColor,
      title: Text(
        song.input,
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
