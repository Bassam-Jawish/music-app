import 'package:equatable/equatable.dart';
class SongEntity extends Equatable {
  final String? title;
  final String? artist;
  final String? albumArtUrl;
  final String? streamingUrl;
  final String? id;

  const SongEntity({
    this.title,
    this.artist,
    this.albumArtUrl,
    this.streamingUrl,
    this.id,
  });

  @override
  List<Object?> get props => [title, artist, albumArtUrl, streamingUrl, id];
}
