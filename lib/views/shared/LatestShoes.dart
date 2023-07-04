import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LatestShoes extends StatelessWidget {
  final String imageUrl;

  const LatestShoes({
    super.key,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
          color: Color(0XFFEBEEEF)
      ),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.28,
      child: CachedNetworkImage(
          imageUrl: imageUrl
      ),

    );
  }
}
