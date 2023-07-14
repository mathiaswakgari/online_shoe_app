import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:online_shoe_app/controllers/wishlistProvider.dart';
import 'package:provider/provider.dart';
import '../shared/app_style.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final _wishlistBox = Hive.box("wishlist");



  @override
  Widget build(BuildContext context) {
  final wishlistNotifier = Provider.of<WishlistNotifier>(context);
  wishlistNotifier.getWishlistData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        width:375.w ,
        height: 812.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.h),
                bottomRight:  Radius.circular(12.h),
              ),
              child: Container(
                width:375.w ,
                height: (812 * 0.4).h,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/adidasOne.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0.w),
                  child: Text(
                    "My Wishlist",
                    style: appStyle(36, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 235.h,
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child:wishlistNotifier.wishlists.isEmpty ?
                  Center(
                    child: Text(
                      "Currently Empty\n Ooops...",
                      style: appStyle(40, Colors.black, FontWeight.bold),
                    ),
                  )
                  :ListView.builder(
                      itemCount: wishlistNotifier.wishlists.length,
                      padding:  EdgeInsets.only(top: 100.h),
                      itemBuilder: (BuildContext context, int index){
                        final shoe = wishlistNotifier.wishlists[index];
                        return Padding(padding: EdgeInsets.all(8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12.h)),
                            child: Container(
                              height: (812 * 0.14).h,
                              width: 375.w,
                              decoration:const BoxDecoration(
                                color: Color(0XFFEBEEEF)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12.h),
                                          child: CachedNetworkImage(
                                          imageUrl: shoe['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12.h, left: 20.w),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                shoe['name'],
                                                overflow: TextOverflow.ellipsis,
                                                style: appStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold
                                                ),),
                                              Text(
                                                shoe['category'],
                                                style: appStyle(
                                                    14,
                                                    Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    shoe['price'],
                                                    style: appStyle(
                                                        18, Colors.black, FontWeight.bold),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: GestureDetector(
                                      onTap: ()async{
                                        wishlistNotifier.deleteWishlist(shoe['key']);
                                        wishlistNotifier.ids.removeWhere((element) => element == shoe['id']);
                                      },
                                      child: const Icon(CupertinoIcons.heart_slash_fill),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
              ),
            )
          ],
        ),
      )
    );
  }
}
