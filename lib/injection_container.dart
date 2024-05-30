import 'package:audio_service/audio_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/features/songs/data/data_sources/remote/songs_api_service.dart';
import 'package:music_app/features/songs/data/repository/song_repo_impl.dart';
import 'package:music_app/features/songs/domain/repository/song_repo.dart';
import 'package:music_app/features/songs/domain/usecases/get_songs_usecase.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'config/config.dart';
import 'core/app_export.dart';
import 'core/network/network_info.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/song_handler.dart';

final sl = GetIt.instance;

// define main variables

int selectIndex = -1;

String appName = '';

String packageName = '';

String version = '';

String buildNumber = '';

Future<void> initializeDependencies() async {
  // Bloc Observer

  Bloc.observer = MyBlocObserver();

  // App Info

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;

  // Dio
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  // init dio
  sl.registerSingleton<Dio>(dio);

  sl.registerSingleton<SongHandler>(
    SongHandler(),
  );

  // Dependencies (Services)
  sl.registerSingleton<SongsApiService>(SongsApiService(sl()));

  // Repositories
  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<GetSongsUseCase>(GetSongsUseCase(sl()));

  // Network
  sl.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker()),
  );

  // Bloc
  sl.registerFactory<SongBloc>(
    () => SongBloc(
      sl<GetSongsUseCase>(),
      sl<NetworkInfo>(),
      sl<SongHandler>(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
