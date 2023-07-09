import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
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
  final _cartBox = Hive.box('cart');

  final _wishlistBox = Hive.box("wishlist");

  Future<void> _createCart(Map<String, dynamic> newCart)async{
    await _cartBox.add(newCart);
  }

  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = Provider.of<WishlistNotifier>(context, listen: true);
    wishlistNotifier.getWishlists();

    return Scaffold(
      body: Consumer<ProductScreenNotifier>(
          builder: (context, productScreenNotifier ,child){
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
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
                                      height: MediaQuery.of(context).size.height * 0.39,
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color(0XFFEBEEEF),
                                      child: CachedNetworkImage(
                                          imageUrl: widget.shoe.imageUrl[index]),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height * 0.109,
                                      right: 20 ,
                                      child: Consumer<WishlistNotifier>(
                                        builder: (context, wishlistNotifier, child){
                                          return GestureDetector(
                                              onTap: ()async{
                                                if(wishlistNotifier.ids.contains(widget.shoe.id)){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context)=> const AddScreen()
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
                                        top: 200,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                                  widget.shoe.imageUrl.length,
                                                  (index) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: CircleAvatar(
                                              radius: 5,
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
                            bottom: 10,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.645,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.all(12),
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
                                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                        const SizedBox(
                                          height: 20,
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
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.green,
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
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
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                  itemCount: widget.shoe.sizes.length,
                                                  scrollDirection: Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (context, index){
                                                    final sizes = productScreenNotifier.selectedSizes[index];

                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 10.0),
                                                    child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20)
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

                                                          print(productScreenNotifier.sizes);

                                                          productScreenNotifier.toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                  }
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              color: Colors.black87,
                                              endIndent: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              child: Text(
                                                  widget.shoe.title,
                                                  style: appStyle(26, Colors.black, FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              widget.shoe.description,
                                              maxLines: 3,
                                              style: appStyle(
                                                  14,
                                                  Colors.black,
                                                  FontWeight.normal),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 50,
                                              child: ElevatedButton(
                                                  style:ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black
                                                  ),
                                                  onPressed: ()async{
                                                      _createCart({
                                                        "id": widget.shoe.id,
                                                        "name": widget.shoe.name,
                                                        "category" : widget.shoe.category,
                                                        "sizes": widget.shoe.sizes,
                                                        "imageUrl": widget.shoe.imageUrl[0],
                                                        "price": widget.shoe.price,
                                                        "qty": 1,
                                                      });
                                                      productScreenNotifier
                                                          .sizes.clear();
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
