// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/kcolors.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.shimmerWidth, required this.shimmerHeight, required this.shimmerRadius});

  final double shimmerWidth;
  final double shimmerHeight;
  final double shimmerRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: shimmerWidth,
      height: shimmerHeight,
      child: _buildShimmerLine(height: shimmerHeight, width: shimmerHeight, radius: shimmerRadius),
    );
  }

  Widget _buildShimmerLine(
      {required double height, required double width, required double radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Kolors.kGray.withOpacity(0.3),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
