import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/features/songs/presentation/widgets/play_pause_button.dart';
import 'package:music_app/features/songs/presentation/widgets/song_progress.dart';
import 'package:music_app/injection_container.dart';
import '../../../../config/theme/app_decoration.dart';
import '../../../../core/app_export.dart';
import '../bloc/song_bloc.dart';

class SongProfileBody extends StatelessWidget {
  const SongProfileBody(this.title, this.artist, this.streamingUrl, {Key? key})
      : super(key: key);

  final String title;
  final String artist;
  final String streamingUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: AppDecoration.profileGradient,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: Icon(
                      Icons.chevron_left_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
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
                                    color: Colors.white.withOpacity(
                                      0.9,
                                    ),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                state.currentSong!.artist!,
                                style: Styles.textStyle18.copyWith(
                                    color: Colors.white.withOpacity(
                                      0.5,
                                    ),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                    SongProgress(
                      totalDuration: state.duration!,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<SongBloc>()
                                  .add(SkipToPreviousSong());
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
