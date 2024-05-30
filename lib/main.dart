import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_themes.dart';
import 'core/app_export.dart';
import 'core/utils/request_song_permission.dart';
import 'core/utils/song_handler.dart';
import 'injection_container.dart';

SongHandler songHandler = SongHandler();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  await initializeDependencies();
  configLoading();

  songHandler = await AudioService.init(
    builder: () => SongHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.music.app',
      androidNotificationChannelName: 'Music Player',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );

  // await requestSongPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SongBloc>(create: (BuildContext context) => sl()..add(GetSongs(songHandler))),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            builder: EasyLoading.init(),
            title: 'Music App',
            theme: theme(),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
