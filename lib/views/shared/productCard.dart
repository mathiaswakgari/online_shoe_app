import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/controllers/wishlistProvider.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';
import 'package:online_shoe_app/views/ui/wishlistScreen.dart';
import 'package:provider/provider.dart';

import '../../models/wishList.dart';

class ShoeCard extends StatefulWidget {
  const ShoeCard(
      {
        Key? key,
        required this.price,
        required this.category,
        required this.id,
        required this.name,
        required this.image}) : super(key: key);

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = Provider.of<WishlistNotifier>(context, listen: true);
    wishlistNotifier.getWishlists();
    return Padding(
        padding: EdgeInsets.fromLTRB(8.w, 0, 29.w, 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            height: 812.h,
            width: (375 * 0.6).w,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0XFFEBEEEF),
                  spreadRadius: 1,
                  blurRadius: 0.6,
                  offset: Offset(1, 1)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: (812 * 0.2).h,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.image))
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                        top: 10.h,
                        child: GestureDetector(
                          onTap: ()async{
                            if(wishlistNotifier.ids.contains(widget.id)){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context)=> const WishlistScreen()
                                  )
                              );
                            }
                            else{
                              wishlistNotifier.createWishlist({
                                "id": widget.id,
                                "name": widget.name,
                                "category": widget.category,
                                "price": widget.price,
                                "imageUrl": widget.image,
                              });
                            }
                            setState(() {});
                          },
                          child: wishlistNotifier.ids.contains(widget.id)?
                              const Icon(CupertinoIcons.heart_fill):
                              const Icon(CupertinoIcons.heart),
                        ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: appStyleTwo(16, 1.1, Colors.black, FontWeight.bold)),
                        Text(widget.category, style: appStyleTwo(18, 1.5, Colors.grey, FontWeight.bold)),
                      ],
                    ),
                ),
                Padding(
                    padding:EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          widget.price,
                          style: appStyle(30, Colors.black, FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Color",
                            style: appStyle(18, Colors.grey, FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ChoiceChip(
                              label: const Text(""),
                              selected: selected,
                              visualDensity: VisualDensity.compact,
                              selectedColor: Colors.black,
                          )
                        ],
                      )

                    ],
                  ),

                )
              ],
            ),
          ),
        ),
    );
  }
}
