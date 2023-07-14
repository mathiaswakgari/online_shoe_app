import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:online_shoe_app/controllers/cartScreenProvider.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/controllers/wishlistProvider.dart';
import 'package:online_shoe_app/models/shoeModel.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';
import 'package:online_shoe_app/views/ui/wishlistScreen.dart';
import 'package:provider/provider.dart';

import '../../models/wishList.dart';

class ProductScreen extends StatefulWidget {
  final Shoe shoe;

  const ProductScreen({Key? key, required this.shoe}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = Provider.of<WishlistNotifier>(context, listen: true);
    wishlistNotifier.getWishlists();
    final cartNotifier = Provider.of<CartScreenNotifier>(context);

    return Scaffold(
      body: Consumer<ProductScreenNotifier>(
          builder: (context, productScreenNotifier ,child){
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding:  EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close, color: Colors.black,),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.ellipsis, color: Colors.black,),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 812.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height: (812 * 0.5).h,
                          width: 375.w,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.shoe.imageUrl.length,
                              controller: _pageController,
                              onPageChanged: (page){
                                productScreenNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index){
                                return Stack(
                                  children: [
                                    Container(
                                      height: (812 * 0.39).h,
                                      width: 375.w,
                                      color: const Color(0XFFEBEEEF),
                                      child: CachedNetworkImage(
                                          imageUrl: widget.shoe.imageUrl[index]),
                                    ),
                                    Positioned(
                                      top: (812 * 0.109).h,
                                      right: 20.w ,
                                      child: Consumer<WishlistNotifier>(
                                        builder: (context, wishlistNotifier, child){
                                          return GestureDetector(
                                              onTap: ()async{
                                                if(wishlistNotifier.ids.contains(widget.shoe.id)){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context)=> const WishlistScreen()
                                                      )
                                                  );
                                                }
                                                else{
                                                  wishlistNotifier.createWishlist({
                                                    "id": widget.shoe.id,
                                                    "name": widget.shoe.name,
                                                    "category": widget.shoe.category,
                                                    "price": widget.shoe.price,
                                                    "imageUrl": widget.shoe.imageUrl[0],
                                                  });
                                                }
                                                setState(() {
                                                });
                                              },
                                              child: wishlistNotifier.ids.contains(widget.shoe.id)?
                                              const Icon(CupertinoIcons.heart_fill):
                                              const Icon(CupertinoIcons.heart));
                                        },
                                      )
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        top: 200.h,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                                  widget.shoe.imageUrl.length,
                                                  (index) => Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                                            child: CircleAvatar(
                                              radius: 5.h,
                                              backgroundColor: productScreenNotifier
                                                  .activePage == index ?
                                              Colors.black : Colors.grey,
                                            ) ,
                                          )),
                                        )),
                                  ],
                                );
                              }
                          ),
                        ),
                        Positioned(
                            bottom: 10.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.h),
                                topRight: Radius.circular(30.h),
                              ),
                              child: Container(
                                // height: (812 * 0.645).h,
                                width: 375.w,
                                margin: EdgeInsets.only(bottom: 20.h),
                                color: Colors.white,
                                child: Padding(
                                    padding:  EdgeInsets.all(12.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.shoe.name,
                                          style: appStyle(30, Colors.black87, FontWeight.bold),),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget.shoe.category,
                                              style: appStyle(20, Colors.grey, FontWeight.w500),),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            RatingBar.builder(
                                                initialRating: 0,
                                                minRating: 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 20,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                                                itemBuilder: (context, _)=> const Icon(
                                                  CupertinoIcons.star_fill,
                                                  color: Colors.black,
                                                ),
                                                onRatingUpdate: (rating) {
                                                    productScreenNotifier.rating = rating;
                                                }
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "\$${widget.shoe.price}",
                                                style: appStyle(26, Colors.black, FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appStyle(18, Colors.black, FontWeight.w500),),
                                                 SizedBox(
                                                  width: 5.w,
                                                ),
                                                 CircleAvatar(
                                                  radius: 7.h,
                                                  backgroundColor: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                CircleAvatar(
                                                  radius: 7.h,
                                                  backgroundColor: Colors.green,
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Available Sizes",
                                                  style: appStyle(20, Colors.black, FontWeight.w600),
                                                ),
                                                Text(
                                                  "Size guide not available",
                                                  style: appStyle(15, Colors.grey, FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                              child: ListView.builder(
                                                  itemCount: widget.shoe.sizes.length,
                                                  scrollDirection: Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (context, index){
                                                    final sizes = productScreenNotifier.selectedSizes[index];

                                                  return Padding(
                                                    padding: EdgeInsets.only(right: 10.0.w),
                                                    child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.h)
                                                        ),
                                                        disabledColor: Colors.white,
                                                        label: Text(
                                                          widget.shoe.sizes[index]['size'],
                                                          style: appStyle(
                                                              18,
                                                              sizes["isSelected"]? Colors.white: Colors.black,
                                                              FontWeight.w500),
                                                        ),
                                                        selectedColor: Colors.black,
                                                        selected: sizes["isSelected"],
                                                        onSelected: (selection){
                                                          if(productScreenNotifier
                                                              .sizes.contains(sizes[
                                                                'size'])){
                                                            productScreenNotifier.
                                                            sizes.remove(sizes['size']);
                                                          }
                                                          else{
                                                            productScreenNotifier.
                                                            sizes.add(sizes['size']);
                                                          }
                                                          productScreenNotifier.toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                  }
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              color: Colors.black87,
                                              endIndent: 10,
                                            ),
                                            SizedBox(
                                              width: (812 * 0.9).w,
                                              child: Text(
                                                  widget.shoe.title,
                                                  style: appStyle(26, Colors.black, FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Container(
                                              height: 50.h,
                                              color: Colors.transparent,
                                              child: Text(
                                                widget.shoe.description,
                                                overflow: TextOverflow.fade,
                                                style: appStyle(
                                                    14,
                                                    Colors.black,
                                                    FontWeight.normal),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            SizedBox(
                                            width: 375.w,
                                            height: 50.h,
                                            child: ElevatedButton(
                                                style:ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black
                                                ),
                                                onPressed: ()async{
                                                    cartNotifier.createCart({
                                                      "id": widget.shoe.id,
                                                      "name": widget.shoe.name,
                                                      "category" : widget.shoe.category,
                                                      "sizes": widget.shoe.sizes,
                                                      "imageUrl": widget.shoe.imageUrl[0],
                                                      "price": widget.shoe.price,
                                                      "qty": 1,
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                child: Text(
                                                    "Add to cart",
                                                    style: appStyle(18, Colors.white, FontWeight.bold),
                                                )),
                                              )
                                          ],
                                        )
                                      ],
                                    ),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
