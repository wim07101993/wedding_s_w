import 'package:admin_app/song_requests/behaviours/remove_song_request.dart';
import 'package:flutter/material.dart';
import 'package:shared/dependency_management.dart';
import 'package:shared/song_requests.dart';
import 'package:shared/string_extensions.dart';

class SpotifySongRequestListItem extends StatelessWidget {
  const SpotifySongRequestListItem({
    super.key,
    required this.song,
    this.onTap,
  });

  final SpotifySong song;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final song = this.song;
    final title = song.title;
    final artists = song.artists.join(', ').nullIfEmpty;
    final album = song.albumName;
    final albumCoverUrl = song.albumCoverUrl;

    final subtitle = artists != null && album != null
        ? '$album - $artists'
        : album ?? artists;

    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      tileColor: theme.cardColor,
      leading: albumCoverUrl != null ? _albumCoverUrl(albumCoverUrl) : null,
      title: Text(
        title ?? 'Geen titel',
        style: TextStyle(color: theme.primaryColor),
      ),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: IconButton(
        onPressed: () => getIt(context).get<RemoveSongRequest>()(song),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  Widget _albumCoverUrl(String url) {
    return Image.network(
      url,
      loadingBuilder: (context, widget, chunk) {
        if (chunk == null) {
          return widget;
        }
        final total = chunk.expectedTotalBytes;
        if (total == null) {
          return const CircularProgressIndicator();
        }
        final downloaded = chunk.cumulativeBytesLoaded;
        return CircularProgressIndicator(
          value: downloaded.toDouble() / total.toDouble(),
        );
      },
    );
  }
}
