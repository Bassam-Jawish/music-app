
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/song_model.dart';

part 'songs_api_service.g.dart';

@RestApi()
abstract class SongsApiService {
  factory SongsApiService(Dio dio) {
    return _SongsApiService(dio);
  }

  @GET('/songs')
  Future<HttpResponse<List<SongModel>>> getSongs();
}