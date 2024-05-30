import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/core/widgets/custom_image_view.dart';
import 'package:music_app/features/songs/domain/entities/song.dart';
import 'package:music_app/features/songs/presentation/widgets/play_pause_button.dart';
import 'package:music_app/features/songs/presentation/widgets/song_progress.dart';

import '../../../../config/routes/app_router.dart';
import '../bloc/song_bloc.dart';

class MiniPlayer extends StatelessWidget {
  // Constructor for the PlayerDeck class
  MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocBuilder<SongBloc, SongState>(
          builder: (context, state) {
            SongEntity? playingSong = state.currentSong;
            return _buildCard(context, playingSong!);
          },
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, SongEntity playingSong) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _buildArtworkOverlay(),
          _buildContent(context, playingSong),
        ],
      ),
    );
  }

  Widget _buildArtworkOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SongEntity playingSong) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(context, playingSong),
        BlocBuilder<SongBloc, SongState>(
          builder: (context, state) {
            return _buildProgress(state.duration ?? Duration.zero);
          },
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, SongEntity playingSong) {
    return ListTile(
      tileColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          /*   final songTitle = playingSong.title;
          final songArtist = playingSong.artist;
          final albumArtUrl =
              playingSong.albumArtUrl;
          final streamingUrl =
              playingSong.streamingUrl;
          final encodedSongTitle = Uri.encodeComponent(songTitle!);
          final encodedSongArtist =
          Uri.encodeComponent(songArtist!);
          final encodedAlbumArtUrl =
          Uri.encodeComponent(albumArtUrl!);
          final encodedStreamingUrl =
          Uri.encodeComponent(streamingUrl!);
*/
          GoRouter.of(context).push(
            '${AppRouter.kHomePage}/${AppRouter.kSongPage}',
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
          ),
          child: CustomImageView(
            imagePath: playingSong.albumArtUrl ?? "",
          ),
        ),
      ),
      title: Text(
        playingSong.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.textStyle14.copyWith(color: Colors.white),
      ),
      subtitle: playingSong.artist == null
          ? null
          : Text(
              playingSong.artist!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle12.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w400),
            ),
      trailing: SizedBox(
        height: 50.h,
        width: 50.w,
        child: _buildTrailingWidget(context, playingSong),
      ),
    );
  }

  Widget _buildTrailingWidget(BuildContext context, SongEntity playingSong) {
    return Stack(
      children: [
        BlocBuilder<SongBloc, SongState>(
          builder: (context, state) {
            if (state.selectedIndexSong != null &&
                state.selectedIndexSong! < state.songsListEntity!.length) {
              return Center(
                child: PlayPauseButton(
                  size: 30,
                  index: state.selectedIndexSong!,
                  currentSong: state.songsListEntity![state.selectedIndexSong!],
                  type: 0,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  // Build the song progress section
  Widget _buildProgress(Duration? totalDuration) {
    return ListTile(
      title: SongProgress(totalDuration: totalDuration),
    );
  }
}
