import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';

import '../../../../config/theme/styles.dart';
import '../../../../core/app_export.dart';
import '../../../../main.dart';

class SongProgress extends StatelessWidget {
  final Duration? totalDuration;

  const SongProgress({
    super.key,
    this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, positionSnapshot) {
        // Retrieve the current position from the stream
        Duration? position = positionSnapshot.data;
        // Display the ProgressBar widget
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
          child: ProgressBar(
            progress: position ?? Duration.zero,
            // buffered: Duration(milliseconds: 2000),
            total: totalDuration ?? Duration.zero,
            onSeek: (position) {
              BlocProvider.of<SongBloc>(context).songHandler.seek(position);
            },
            progressBarColor: Colors.red,
            baseBarColor: Colors.white.withOpacity(0.24),
            bufferedBarColor: Colors.white.withOpacity(0.24),
            thumbColor: Colors.white,
            barHeight: 3.h,
            thumbRadius: 5.h,
            timeLabelTextStyle: Styles.textStyle14,
          ),
        );
      },
    );
  }
}
