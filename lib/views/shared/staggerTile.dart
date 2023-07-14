import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';

class StaggerTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String price;

  const StaggerTile(
      {
        Key? key,
        required this.imageUrl,
        required this.name,
        required this.price}) : super(key: key);

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: const Color(0xFFEBEEEF),
        borderRadius: BorderRadius.circular(16.h)
      ),
      child: Padding(
          padding: EdgeInsets.all(8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl, fit: BoxFit.fill,),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: appStyle(15, Colors.black, FontWeight.w700),),
                    Text("\$${widget.price}", style: appStyle(20, Colors.black, FontWeight.w500),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
