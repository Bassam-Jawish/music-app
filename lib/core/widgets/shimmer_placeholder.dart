import 'package:flutter/material.dart';

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({Key? key, this.height, this.width, this.radius = 15}) : super(key: key);

  final double? height, width;

  final double radius;

  // Constructor to initialize radius
  ShimmerPlaceholder.withRadius({
    Key? key,
    this.height,
    this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    );
  }
}
