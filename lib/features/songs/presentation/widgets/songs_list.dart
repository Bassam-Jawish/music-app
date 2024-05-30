import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/core/widgets/custom_image_view.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:music_app/features/songs/presentation/widgets/play_pause_button.dart';

class SongListWidget extends StatelessWidget {
  final SongState state;

  const SongListWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.songsListEntity!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          if (state.isPlaying![index] == false) {
            context.read<SongBloc>().add(
              PlaySong(state.songsListEntity![index], index),
            );
          } else {
            context.read<SongBloc>().add(PauseSong());
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Color(0xFF30314D),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CustomImageView(
                  imagePath: state.songsListEntity![index].albumArtUrl,
                  fit: BoxFit.fill,
                  height: 50.h,
                  width: 50.h,
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 180.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.songsListEntity![index].title!,
                      style: Styles.textStyle18.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      state.songsListEntity![index].artist!,
                      style: Styles.textStyle14.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              PlayPauseButton(
                size: 30,
                index: index,
                currentSong: state.songsListEntity![index],
                type: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}