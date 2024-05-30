import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';

class SongInfoWidget extends StatelessWidget {
  final SongState state;

  const SongInfoWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.currentSong!.title!,
                style: Styles.textStyle24.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                state.currentSong!.artist!,
                style: Styles.textStyle18.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            Icons.favorite,
            color: Colors.red,
            size: 35,
          ),
        ],
      ),
    );
  }
}