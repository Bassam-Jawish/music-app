import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:music_app/core/widgets/custom_toast.dart';
import 'package:music_app/features/songs/presentation/widgets/shimmer_home_loading.dart';
import 'package:music_app/features/songs/presentation/widgets/songs_list.dart';
import 'package:music_app/features/songs/presentation/widgets/search_bar_widget.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:music_app/features/songs/presentation/widgets/mini_player.dart';
import '../../../../config/theme/styles.dart';

class SongsBody extends StatelessWidget {
  SongsBody({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongBloc, SongState>(
      listener: (context, state) {
        if (state.songsStatus == SongsStatus.error) {
          showToast(text: state.error!.message, state: ToastState.error);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: Text(
                        "Hello Rand",
                        style: Styles.textStyle30.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: Text(
                        "What do you want to hear today?",
                        style: Styles.textStyle16.copyWith(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: SearchBarWidget(controller: searchController),
                    ),
                    ConditionalBuilder(
                      condition: !state.isLoading!,
                      builder: (context) => SongListWidget(state: state),
                      fallback: (context) => ShimmerHomeLoading(),
                    ),
                  ],
                ),
              ),
            ),
            state.currentSong == null ? SizedBox.shrink() : MiniPlayer(),
          ],
        );
      },
    );
  }
}