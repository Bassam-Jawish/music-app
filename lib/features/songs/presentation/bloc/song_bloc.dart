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
  final SongHandler _songHandler;

  SongBloc(this._getSongsUseCase, this._networkInfo, this._songHandler)
      : super(const SongState().copyWith(
            songsStatus: SongsStatus.initial, isLoading: true, isPlaying: [])) {
    _initializeAudioService();
    on<GetSongs>(onGetSongs);
    on<SearchForSongs>(onSearchForSongs);
    on<PlaySong>(onPlaySong);
    on<PauseSong>(onPauseSong);
    on<SkipToNextSong>(onSkipToNextSong);
    on<SkipToPreviousSong>(onSkipToPreviousSong);
  }

  Future<void> _initializeAudioService() async {
    await AudioService.init(
      builder: () => _songHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.music.app',
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

        await _songHandler.initSongs(urls: audioUrls);

        List<bool> booleanArray = List.filled(dataState.data!.length, false);

        emit(state.copyWith(
          songsListEntity: dataState.data,
          songsListEntityFixed: dataState.data,
          isPlaying: booleanArray,
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
    List<SongEntity> songs = state.songsListEntityFixed!;

    songs = songs
        .where((element) =>
            element.title!.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(
        songsListEntity: songs, songsStatus: SongsStatus.search));
  }

  void onPlaySong(PlaySong event, Emitter<SongState> emit) async {
    SongEntity song = event.song;
    List<bool> isPlaying = state.isPlaying!;

    print("Testing Before anything");
    print("newIndex=${event.index}");
    print("isPlayingArray=${isPlaying}");
    if (state.selectedIndexSong != null) {
      print("selectedIndexSong=${state.selectedIndexSong}");
      print("isPlayingOld=${isPlaying[state.selectedIndexSong!]}");
    }
    print("isPlayingNew=${isPlaying[event.index]}");

    try {
      bool initSong = false;

      if (state.selectedIndexSong != event.index) {
        if (state.selectedIndexSong != null) {
          isPlaying[state.selectedIndexSong!] = false;

          print("Testing When another song is clicked");
          print("selectedIndexSong=${state.selectedIndexSong}");
          print("newIndex=${event.index}");
          print("isPlayingArray=${isPlaying}");
          print("isPlayingOld=${isPlaying[state.selectedIndexSong!]}");
          print("isPlayingNew=${isPlaying[event.index]}");
        }

        print("Testing When It's null, selectedIndexSong != event.index");
        print("newIndex=${event.index}");
        print("isPlayingArray=${isPlaying}");
        if (state.selectedIndexSong != null) {
          print("selectedIndexSong=${state.selectedIndexSong}");
          print("isPlayingOld=${isPlaying[state.selectedIndexSong!]}");
        }
        print("isPlayingNew=${isPlaying[event.index]}");

        initSong = true;
      }

      isPlaying[event.index] = true;

      print("Testing after change isPlayingValue");
      print("newIndex=${event.index}");
      print("isPlayingArray=${isPlaying}");
      if (state.selectedIndexSong != null) {
        print("selectedIndexSong=${state.selectedIndexSong}");
        print("isPlayingOld=${isPlaying[state.selectedIndexSong!]}");
      }
      print("isPlayingNew=${isPlaying[event.index]}");

      emit(state.copyWith(
        selectedIndexSong: event.index,
        isPlaying: isPlaying,
        currentSong: song,
      ));

      if (initSong) {
        await _songHandler.skipToQueueItem(event.index);
      } else {
        await _songHandler.play();
      }

      final duration = await _songHandler.getCurrentSongDuration();

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
      List<bool> isPlaying = state.isPlaying!;
      isPlaying[state.selectedIndexSong!] = false;
      await _songHandler.pause();
      print("Testing when pause");
      print("selectedIndexSong=${state.selectedIndexSong}");
      print("isPlayingArray=${isPlaying}");
      print("isPlayingChanged=${isPlaying[state.selectedIndexSong!]}");

      emit(state.copyWith(
          isPlaying: isPlaying,
          songsStatus: SongsStatus.pause,));
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

        await _songHandler.skipToNext();

        final duration = await _songHandler.getCurrentSongDuration();

        emit(state.copyWith(songsStatus: SongsStatus.skipToNext, duration: duration));

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

        await _songHandler.skipToPrevious();

        final duration = await _songHandler.getCurrentSongDuration();

        emit(state.copyWith(songsStatus: SongsStatus.skipToNext, duration: duration));
      }
    } catch (e) {
      emit(state.copyWith(
        songsStatus: SongsStatus.error,
        error: PlaybackFailure('Failed to skip to previous song'),
      ));
    }
  }
}
