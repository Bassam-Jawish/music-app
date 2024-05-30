import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';

import '../../domain/entities/song.dart';

class PlayPauseButton extends StatelessWidget {
  final double size;
  final int index;
  final SongEntity currentSong;

  final int type;

  PlayPauseButton({
    super.key,
    required this.size,
    required this.index,
    required this.currentSong,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(builder: (context, state) {
      if (type == 0) {
        bool playing = state.isPlaying![index];
        return IconButton(
          onPressed: () {
            if (playing) {
              print("index=${index}");
              context.read<SongBloc>().add(PauseSong());
            } else {
              print("index=${index}");
              context.read<SongBloc>().add(PlaySong(currentSong!, index));
            }
          },
          icon: playing
              ? Icon(
                  Icons.pause_circle_filled_outlined,
                  size: size,
                  color: Colors.white,
                )
              : Icon(Icons.play_circle_fill_outlined,
                  size: size, color: Colors.white),
        );
      } else {
        bool playing = state.isPlayingChange![index];
        return IconButton(
          onPressed: () {
            if (playing) {
              context.read<SongBloc>().add(PauseSong());
            } else {
              context.read<SongBloc>().add(PlaySong(currentSong!, index));
            }
          },
          icon: playing
              ? Icon(
                  Icons.pause_circle_filled_outlined,
                  size: size,
                  color: Colors.white,
                )
              : Icon(Icons.play_circle_fill_outlined,
                  size: size, color: Colors.white),
        );
      }
    });
  }
}
