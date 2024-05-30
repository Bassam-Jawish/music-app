import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_app/features/songs/domain/entities/song.dart';
/*
// Convert a SongModel to a MediaItem
Future<MediaItem> songToMediaItem(SongEntity song) async {
  try {
    // Get the artwork for the song
    final Uri? art = await getSongArt(
      id: song.id,
      type: ArtworkType.AUDIO,
      quality: 100,
      size: 300,
    );

    // Create and return a MediaItem
    return MediaItem(
      // Use the song URI as the MediaItem ID
      id: song.uri.toString(),

      // Set the artwork URI obtained earlier
      artUri: art,

      // Format the song title using the provided utility function
      title: formattedTitle(song.title).trim(),

      // Set the artist, duration, and display description
      artist: song.artist,
      duration: Duration(milliseconds: song.duration!),
      displayDescription: song.id.toString(),
    );
  } catch (e) {
    // Handle any errors that occur during the process
    debugPrint('Error converting SongModel to MediaItem: $e');
    // Return a default or null MediaItem in case of an error
    return const MediaItem(id: '', title: 'Error', artist: 'Unknown');
  }
}
*/