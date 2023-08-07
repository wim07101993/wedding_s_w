import 'package:admin_app/song_requests/behaviours/remove_song_request.dart';
import 'package:flutter/material.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/song_requests.dart';

class FreeInputSongRequestListItem extends StatefulWidget {
  const FreeInputSongRequestListItem({
    super.key,
    required this.song,
  });

  final FreeInputSongRequest song;

  @override
  State<FreeInputSongRequestListItem> createState() =>
      _FreeInputSongRequestListItemState();
}

class _FreeInputSongRequestListItemState
    extends State<FreeInputSongRequestListItem> {
  bool isDeleting = false;

  Future<void> deleteItem() async {
    setState(() => isDeleting = true);
    try {
      await getIt<RemoveSongRequest>()(widget.song);
    } finally {
      if (mounted) {
        setState(() => isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: theme.cardColor,
      title: Text(
        widget.song.input,
        style: TextStyle(color: theme.primaryColor),
      ),
      trailing: isDeleting
          ? const CircularProgressIndicator()
          : IconButton(
              onPressed: () => getIt<RemoveSongRequest>()(widget.song),
              icon: const Icon(Icons.delete),
            ),
    );
  }
}
