
import 'package:music_app/features/songs/domain/entities/song.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/song_repo.dart';

class GetSongsUseCase implements UseCase<DataState<List<SongEntity>>, void> {
  final SongsRepository songsRepository;

  GetSongsUseCase(this.songsRepository);

  @override
  Future<DataState<List<SongEntity>>> call({void params}) {
    return songsRepository.getSongs();
  }

}