import 'package:behaviour/behaviour.dart';
import 'package:flutter/material.dart';
import 'package:wedding_s_w/features/song_requests/behaviours/search_songs.dart';
import 'package:wedding_s_w/features/song_requests/models/song_request.dart';
import 'package:wedding_s_w/features/song_requests/models/spotify_song_request.dart';
import 'package:wedding_s_w/features/song_requests/widgets/song_request_list/spotify_song_request_list_item.dart';
import 'package:wedding_s_w/shared/dependency_management/get_it_provider.dart';
import 'package:wedding_s_w/shared/string_extensions.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.onControllerChanged,
    required this.onSelectSong,
  });

  final void Function(TextEditingController controller) onControllerChanged;
  final void Function(SongRequest song) onSelectSong;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final SearchSongs searchSongs = getIt();
  var _searchController = TextEditingController();

  void onSearchControllerChanged(TextEditingController newController) {
    if (_searchController == newController) {
      return;
    }
    _searchController = newController;
    widget.onControllerChanged(newController);
  }

  void onSongSelected(SpotifySong song) {
    _searchController.clear();
    widget.onSelectSong(song);
  }

  String displayStringForSong(SpotifySong song) {
    final title = song.title ?? 'Geen titel';
    final artist = song.artists.join(', ').nullIfEmpty;
    return artist != null ? '$title - $artist' : title;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<SpotifySong>(
      onSelected: onSongSelected,
      displayStringForOption: displayStringForSong,
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
        onSearchControllerChanged(controller);
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: const InputDecoration(
            hintText: 'Liedje dat je wil aanvragen',
          ),
          onSubmitted: (value) => onSubmitted(),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        );
      },
      optionsBuilder: (value) => value.text.length < 3
          ? Future.value(<SpotifySong>[])
          : searchSongs(value.text).thenWhen(
              (exception) => const <SpotifySong>[],
              (tracks) => tracks,
            ),
      optionsViewBuilder: (context, onSelected, options) => SearchFieldOptions(
        onSelected: onSelected,
        songs: options,
      ),
    );
  }
}

class SearchFieldOptions extends StatelessWidget {
  const SearchFieldOptions({
    super.key,
    required this.songs,
    required this.onSelected,
  });

  final Iterable<SpotifySong> songs;
  final AutocompleteOnSelected<SpotifySong> onSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        color: Colors.white,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: songs
                .map(
                  (song) => SpotifySongRequestListItem(
                    song: song,
                    onTap: () => onSelected(song),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
