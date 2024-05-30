import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/features/songs/presentation/pages/song_profile_page.dart';
import 'package:music_app/features/songs/presentation/pages/songs_page.dart';

import '../../features/splash/presentation/pages/splash_page.dart';

abstract class AppRouter {
  static const kHomePage = '/home';
  static const kSongPage = 'song';
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static bool _splashScreenShown = false;

  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) {
          _splashScreenShown = true;
          return const MaterialPage(child: SplashPage());
        },
      ),
      GoRoute(
          path: kHomePage,
          name: 'home',
          pageBuilder: (context, state) {
            _splashScreenShown = true;
            return const MaterialPage(child: SongsPage());
          },
          routes: [
            GoRoute(
              path: '$kSongPage',
              name: 'song',
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: SongProfilePage());
              },
            ),
          ]),
    ],
    redirect: (context, state) {
      debugPrint(state.fullPath);
      if (!_splashScreenShown) {
        return null;
      }
      if (state.fullPath == kHomePage) {
        return kHomePage;
      }
      return null;
    },
  );
}
