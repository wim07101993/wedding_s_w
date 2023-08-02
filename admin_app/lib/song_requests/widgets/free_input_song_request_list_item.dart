import 'package:admin_app/song_requests/behaviours/remove_song_request.dart';
import 'package:flutter/material.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/song_requests.dart';

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
      trailing: IconButton(
        onPressed: () => getIt(context).get<RemoveSongRequest>()(song),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
