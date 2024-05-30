import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/core/widgets/custom_image_view.dart';
import 'package:music_app/features/songs/presentation/widgets/play_pause_button.dart';
import 'package:music_app/features/songs/presentation/widgets/shimmer_home_loading.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/app_export.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../injection_container.dart';
import '../bloc/song_bloc.dart';
import 'player_deck.dart';

class SongsBody extends StatelessWidget {
  SongsBody({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

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
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.w),
                      child: Text(
                        "What do you want to hear today?",
                        style: Styles.textStyle16
                            .copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SearchBar(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              onChanged: (value) {
                                context.read<SongBloc>().add(
                                      SearchForSongs(searchController!.text),
                                    );
                              },
                              controller: searchController,
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Color(0xFF31314F),
                              ),
                              hintText: 'Search the song',
                              hintStyle: WidgetStateProperty.all<TextStyle>(
                                Styles.textStyle16.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 10.w),
                              ),
                              trailing: [
                                Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                      condition: !state.isLoading!,
                      builder: (context) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.songsListEntity!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            if (state.isPlaying![index] == false) {
                              selectIndex = index;
                              context.read<SongBloc>().add(
                                    PlaySong(
                                        state.songsListEntity![index], index),
                                  );
                            } else {
                              context.read<SongBloc>().add(PauseSong());
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 5.h,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Color(0xFF30314D),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CustomImageView(
                                    imagePath: state
                                        .songsListEntity![index].albumArtUrl,
                                    fit: BoxFit.fill,
                                    height: 50.h,
                                    width: 50.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 180.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.songsListEntity![index].title!,
                                        style: Styles.textStyle18.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      fallback: (context) => ShimmerHomeLoading(),
                    ),
                  ],
                ),
              ),
            ),
            state.currentSong == null
                ? SizedBox.shrink()
                : PlayerDeck(),
          ],
        );
      },
    );
  }
}
