import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:music_app/features/songs/presentation/widgets/play_pause_button.dart';

class SongControlsWidget extends StatelessWidget {
  final SongState state;

  const SongControlsWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              context.read<SongBloc>().add(SkipToPreviousSong());
            },
            icon: Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 30,
            ),
          ),
          PlayPauseButton(
            size: 60,
            index: state.selectedIndexSong!,
            currentSong: state.songsListEntity![state.selectedIndexSong!],
            type: 0,
          ),
          IconButton(
            onPressed: () {
              context.read<SongBloc>().add(SkipToNextSong());
            },
            icon: Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}