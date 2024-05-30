import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/features/songs/domain/usecases/get_songs_usecase.dart';

import '../../../../core/app_export.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/song_handler.dart';
import '../../domain/entities/song.dart';

part 'song_event.dart';

part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetSongsUseCase _getSongsUseCase;
  final NetworkInfo _networkInfo;
  final SongHandler songHandler;

  SongBloc(this._getSongsUseCase, this._networkInfo, this.songHandler)
      : super(const SongState().copyWith(
            songsStatus: SongsStatus.initial,
            isLoading: true,
            isPlaying: [],
            isPlayingChange: [])) {
    _initializeAudioService();
    on<GetSongs>(onGetSongs);
    on<SearchForSongs>(onSearchForSongs);
    on<PlaySong>(onPlaySong);
    on<PauseSong>(onPauseSong);
    on<SkipToNextSong>(onSkipToNextSong);
    on<SkipToPreviousSong>(onSkipToPreviousSong);

    songHandler.audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) onSkipToNextSong;
    });
  }

  Future<void> _initializeAudioService() async {
    await AudioService.init(
      builder: () => songHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.music_app',
        androidNotificationChannelName: 'Music Player',
        androidNotificationOngoing: true,
        androidShowNotificationBadge: true,
      ),
    );
  }

  Future<void> onGetSongs(GetSongs event, Emitter<SongState> emit) async {
    emit(state.copyWith(songsStatus: SongsStatus.loading));

    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: const ConnectionFailure('No Internet Connection'),
      ));
      return;
    }

    try {
      final dataState = await _getSongsUseCase();

      if (dataState is DataSuccess) {
        List<String> audioUrls = dataState.data!
            .map((song) => song.streamingUrl)
            .where((url) => url != null)
            .cast<String>()
            .toList();

        await songHandler.initSongs(urls: audioUrls);

        List<bool> booleanArray = List.filled(dataState.data!.length, false);

        emit(state.copyWith(
          songsListEntity: dataState.data,
          songsListEntityFixed: dataState.data,
          isPlaying: booleanArray,
          isPlayingChange: booleanArray,
          songsStatus: SongsStatus.success,
          isLoading: false,
        ));
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(
            songsStatus: SongsStatus.error,
            error: ServerFailure.fromDioError(dataState.error!)));
      }
    } on DioException catch (e) {
      emit(state.copyWith(
          songsStatus: SongsStatus.error,
          error: ServerFailure.fromDioError(e)));
    }
  }

  void onSearchForSongs(SearchForSongs event, Emitter<SongState> emit) async {
    List<SongEntity> originalSongs = state.songsListEntityFixed!;
    List<SongEntity> filteredSongs = originalSongs
        .where((element) =>
            element.title!.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    List<bool> isPlayingChange = List.filled(filteredSongs.length, false);

    if (state.selectedIndexSong != null) {
      int originalSelectedIndex = state.selectedIndexSong!;
      if (originalSelectedIndex < originalSongs.length) {
        SongEntity currentlyPlayingSong = originalSongs[originalSelectedIndex];

        int newIndex = filteredSongs
            .indexWhere((song) => song.id == currentlyPlayingSong.id);
        if (newIndex != -1) {
          isPlayingChange[newIndex] = true;
        }
      }
    }

    /*List<String> audioUrls = filteredSongs
        .map((song) => song.streamingUrl)
        .where((url) => url != null)
        .cast<String>()
        .toList();

    await songHandler.initSongs(urls: audioUrls);*/

    emit(state.copyWith(
      songsListEntity: filteredSongs,
      isPlayingChange: isPlayingChange,
      songsStatus: SongsStatus.search,
    ));
  }

  void onPlaySong(PlaySong event, Emitter<SongState> emit) async {
    SongEntity song = event.song;
    List<bool> isPlaying = [];
    isPlaying.addAll(state.isPlaying!);

    try {
      bool initSong = false;

      if (state.selectedIndexSong != event.index) {
        if (state.selectedIndexSong != null) {
          isPlaying[state.selectedIndexSong!] = false;
        }

        initSong = true;
      }

      isPlaying[event.index] = true;

      emit(state.copyWith(
        selectedIndexSong: event.index,
        isPlaying: isPlaying,
        currentSong: song,
      ));

      if (initSong) {
        await songHandler.skipToQueueItem(event.index);
      } else {
        await songHandler.play();
      }

      final duration = await songHandler.getCurrentSongDuration();

      emit(state.copyWith(songsStatus: SongsStatus.play, duration: duration));
    } catch (e) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: PlaybackFailure('Failed to play song'),
      ));
    }
  }

  void onPauseSong(PauseSong event, Emitter<SongState> emit) async {
    try {
      List<bool> isPlaying = [];
      isPlaying.addAll(state.isPlaying!);
      isPlaying[state.selectedIndexSong!] = false;
      await songHandler.pause();

      emit(state.copyWith(
        isPlaying: isPlaying,
        songsStatus: SongsStatus.pause,
      ));
    } catch (e) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: PlaybackFailure('Failed to pause song'),
      ));
    }
  }

  void onSkipToNextSong(SkipToNextSong event, Emitter<SongState> emit) async {
    try {
      List<bool> isPlaying = state.isPlaying!;

      if (state.selectedIndexSong! < state.songsListEntity!.length - 1) {
        isPlaying[state.selectedIndexSong!] = false;
        isPlaying[state.selectedIndexSong! + 1] = true;

        emit(state.copyWith(
          currentSong: state.songsListEntity![state.selectedIndexSong! + 1],
          selectedIndexSong: state.selectedIndexSong! + 1,
          isPlaying: isPlaying,
        ));

        await songHandler.skipToNext();

        final duration = await songHandler.getCurrentSongDuration();

        emit(state.copyWith(
            songsStatus: SongsStatus.skipToNext, duration: duration));
      }
    } catch (e) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: PlaybackFailure('Failed to skip to next song'),
      ));
    }
  }

  void onSkipToPreviousSong(
      SkipToPreviousSong event, Emitter<SongState> emit) async {
    try {
      List<bool> isPlaying = state.isPlaying!;

      if (state.selectedIndexSong! > 0) {
        isPlaying[state.selectedIndexSong!] = false;
        isPlaying[state.selectedIndexSong! - 1] = true;

        emit(state.copyWith(
          currentSong: state.songsListEntity![state.selectedIndexSong! - 1],
          selectedIndexSong: state.selectedIndexSong! - 1,
          isPlaying: isPlaying,
        ));

        await songHandler.skipToPrevious();

        final duration = await songHandler.getCurrentSongDuration();

        emit(state.copyWith(
            songsStatus: SongsStatus.skipToNext, duration: duration));
      }
    } catch (e) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: PlaybackFailure('Failed to skip to previous song'),
      ));
    }
  }
}
