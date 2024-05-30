import 'package:flutter/material.dart';
import 'package:music_app/config/theme/app_decoration.dart';
import 'package:music_app/core/widgets/custom_appbar.dart';
import 'package:music_app/core/widgets/custom_image_view.dart';
import 'package:music_app/features/songs/presentation/widgets/song_profile_body.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/app_export.dart';
import '../../../../injection_container.dart';
import '../bloc/song_bloc.dart';

class SongProfilePage extends StatelessWidget {
  const SongProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                state.currentSong!.albumArtUrl!,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: AppColor.transparent,
            appBar: null,
            body: SafeArea(
                child: SongProfileBody(
                    state.currentSong!.title!,
                    state.currentSong!.artist!,
                    state.currentSong!.streamingUrl!)),
          ),
        );
      },
    );
  }
}
