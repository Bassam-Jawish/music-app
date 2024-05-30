import 'package:music_app/features/songs/domain/entities/song.dart';
class SongModel extends SongEntity{
  final String? title;
  final String? artist;
  final String? albumArtUrl;
  final String? streamingUrl;
  final String? id;

  const SongModel({
    this.title,
    this.artist,
    this.albumArtUrl,
    this.streamingUrl,
    this.id,
  });

  factory SongModel.fromJson(Map<String, dynamic> map) {
    return SongModel(
      title: map['title'] ?? "",
      artist: map['artist'] ?? "",
      albumArtUrl: map['albumArtUrl'] ?? "",
      streamingUrl: map['streamingUrl'] ?? "",
      id: map['id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'albumArtUrl': albumArtUrl,
      'streamingUrl': streamingUrl,
      'id': id,
    };
  }
}
