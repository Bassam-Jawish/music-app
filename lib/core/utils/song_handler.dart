
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../features/songs/domain/entities/song.dart';

class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> _urls = [];

  UriAudioSource _createAudioSource(String url) {
    return ProgressiveAudioSource(Uri.parse(url));
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioPlayer.processingState]!,
      playing: audioPlayer.playing,
      updatePosition: audioPlayer.position,
      bufferedPosition: audioPlayer.bufferedPosition,
      speed: audioPlayer.speed,
      queueIndex: event.currentIndex,
    ));
  }

  Future<void> initSongs({required List<String> urls}) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);

    _urls.addAll(urls);

    final audioSource = urls.map(_createAudioSource).toList();

    await audioPlayer.setAudioSource(ConcatenatingAudioSource(children: audioSource));

  }

  @override
  Future<void> play() => audioPlayer.play();

  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }
  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();

  SongEntity? getCurrentSong() {
    final currentIndex = audioPlayer.currentIndex;
    if (currentIndex != null && currentIndex >= 0 && currentIndex < _urls.length) {
      final url = _urls[currentIndex];
      // Create a SongEntity based on the current URL
      return SongEntity(id: currentIndex.toString(), streamingUrl: url); // Adjust as per your SongEntity structure
    }
    return null;
  }

  Duration getCurrentSongDuration() {
    return audioPlayer.duration ?? Duration.zero;
  }

}

