part of 'song_bloc.dart';

enum SongsStatus {
  initial,
  loading,
  success,
  error,
  search,
  play,
  pause,
  skipToNext,
  skipToPrevious,
}

class SongState extends Equatable {
  final List<SongEntity>? songsListEntity;
  final List<SongEntity>? songsListEntityFixed;
  final Failure? error;
  final bool? isLoading;
  final SongsStatus? songsStatus;

  final SongEntity? currentSong;

  final List<bool>? isPlaying;

  final List<bool>? isPlayingChange;

  final Duration? duration;

  final int? selectedIndexSong;

  const SongState(
      {this.songsListEntity,
      this.songsListEntityFixed,
      this.error,
      this.isLoading,
      this.songsStatus,
      this.currentSong,
      this.isPlaying,this.isPlayingChange,
      this.duration,
      this.selectedIndexSong});

  SongState copyWith({
    List<SongEntity>? songsListEntity,
    List<SongEntity>? songsListEntityFixed,
    Failure? error,
    bool? isLoading,
    SongsStatus? songsStatus,
    SongEntity? currentSong,
    List<bool>? isPlaying,
    List<bool>? isPlayingChange,
    Duration? duration,
    int? selectedIndexSong,
  }) =>
      SongState(
        songsListEntity: songsListEntity ?? this.songsListEntity,
        songsListEntityFixed: songsListEntityFixed ?? this.songsListEntityFixed,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        songsStatus: songsStatus ?? this.songsStatus,
        currentSong: currentSong ?? this.currentSong,
        isPlaying: isPlaying ?? this.isPlaying,
        isPlayingChange: isPlayingChange ?? this.isPlayingChange,
        duration: duration ?? this.duration,
        selectedIndexSong: selectedIndexSong ?? this.selectedIndexSong,
      );

  @override
  List<Object?> get props => [
        songsListEntity,
        songsListEntityFixed,
        error,
        isLoading,
        songsStatus,
        currentSong,
        isPlaying,
        isPlayingChange,
        duration,
        selectedIndexSong,
      ];
}
