import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        width:MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight:  Radius.circular(12),
              ),
              child: Container(
                width:MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/adidasOne.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    "My Wishlist",
                    style: appStyle(36, Colors.white, FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 235,
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:wishlistNotifier.wishlists.isEmpty ?
                  Center(
                    child: Text(
                      "Currently Empty\n Ooops...",
                      style: appStyle(40, Colors.black, FontWeight.bold),
                    ),
                  )
                  :ListView.builder(
                      itemCount: wishlistNotifier.wishlists.length,
                      padding: const EdgeInsets.only(top: 100),
                      itemBuilder: (BuildContext context, int index){
                        final shoe = wishlistNotifier.wishlists[index];
                        return Padding(padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.14,
                              width: MediaQuery.of(context).size.width,
                              decoration:const BoxDecoration(
                                color: Color(0XFFEBEEEF)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Padding(padding: const EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: shoe['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 12, left: 20),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                shoe['name'],
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
                                              const SizedBox(
                                                height: 5,
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
                                    padding: const EdgeInsets.all(8),
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
