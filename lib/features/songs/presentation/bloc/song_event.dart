part of 'song_bloc.dart';

sealed class SongEvent extends Equatable {
  const SongEvent();
}

class GetSongs extends SongEvent {

  final SongHandler songHandler;

  const GetSongs(this.songHandler);
  @override
  List<Object> get props => [songHandler];
}

class SearchForSongs extends SongEvent {
  final String query;
  const SearchForSongs(this.query);
  @override
  List<Object> get props => [query];
}

class PlaySong extends SongEvent {
  final SongEntity song;

  final int index;

  const PlaySong(this.song, this.index);

  @override
  List<Object> get props => [song];
}

class PauseSong extends SongEvent {
  const PauseSong();
  @override
  List<Object> get props => [];
}

class SkipToNextSong extends SongEvent {
  const SkipToNextSong();
  @override
  List<Object> get props => [];
}

class SkipToPreviousSong extends SongEvent {
  const SkipToPreviousSong();
  @override
  List<Object> get props => [];
}