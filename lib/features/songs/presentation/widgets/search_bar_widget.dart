import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/config/theme/styles.dart';
import 'package:music_app/features/songs/presentation/bloc/song_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              context.read<SongBloc>().add(SearchForSongs(controller.text));
            },
            controller: controller,
            backgroundColor: WidgetStateProperty.all<Color>(
              Color(0xFF31314F),
            ),
            textStyle: WidgetStateProperty.all<TextStyle>(
              Styles.textStyle14.copyWith(color: Colors.white),
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
    );
  }
}