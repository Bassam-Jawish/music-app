import 'dart:io';

import 'package:dio/dio.dart';
import 'package:music_app/features/songs/data/models/song_model.dart';
import 'package:music_app/features/songs/domain/entities/song.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/repository/song_repo.dart';
import '../data_sources/remote/songs_api_service.dart';

class SongsRepositoryImpl implements SongsRepository {
  final SongsApiService _SongsApiService;

  SongsRepositoryImpl(this._SongsApiService);

  @override
  Future<DataState<List<SongEntity>>> getSongs() async {
    try {
      final httpResponse = await _SongsApiService.getSongs();

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.created) {
        final List<SongModel> model = httpResponse.data;
        final List<SongEntity> entity = model;
        return DataSuccess(entity);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }


}
