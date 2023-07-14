import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestShoes extends StatelessWidget {
  final String imageUrl;

  const LatestShoes({
    super.key,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0XFFEBEEEF),
          borderRadius: BorderRadius.circular(20.h)
      ),
      height: (812 * 0.12).h,
      width: (375 * 0.28).w,
      child: CachedNetworkImage(
          imageUrl: imageUrl
      ),

    );
  }
}
