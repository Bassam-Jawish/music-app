import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/config/theme/app_decoration.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';
import 'package:music_app/features/songs/presentation/widgets/song_controls.dart';
import 'package:music_app/features/songs/presentation/widgets/song_info.dart';
import 'package:music_app/features/songs/presentation/widgets/song_progress.dart';

import 'back_button_widget.dart';

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
                  const BackButtonWidget(),
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
                    SongInfoWidget(state: state),
                    SongProgress(totalDuration: state.duration!),
                    SongControlsWidget(state: state),
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