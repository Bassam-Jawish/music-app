import 'package:flutter/material.dart';
import 'package:music_app/core/widgets/custom_appbar.dart';
import 'package:music_app/features/songs/presentation/widgets/songs_body.dart';

import '../../../../config/theme/app_decoration.dart';
import '../../../../config/theme/colors.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: AppDecoration.primaryGradient,
        ),
        child: Scaffold(
          backgroundColor: AppColor.transparent,
          appBar: CustomAppBar(),
          body: SongsBody(),
        ),
      ),
    );
  }
}
