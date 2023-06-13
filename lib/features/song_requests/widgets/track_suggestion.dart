import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/song_requests/models/spotify_song_request.dart';
import 'package:wedding_s_w/shared/string_extensions.dart';

class SongSuggestion extends StatelessWidget {
  const SongSuggestion({
    super.key,
    required this.song,
    required this.onTap,
  });

  final SpotifySong song;
  final VoidCallback onTap;

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
      leading: albumCoverUrl != null ? Image.network(albumCoverUrl) : null,
      title: Text(
        title ?? 'Geen titel',
        style: TextStyle(color: theme.primaryColor),
      ),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }
}
