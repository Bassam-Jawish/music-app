import 'package:music_app/features/songs/domain/entities/song.dart';

import '../../../../core/resources/data_state.dart';

abstract class SongsRepository {
  // API methods
  Future<DataState<List<SongEntity>>> getSongs();

}
