import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/wishList.dart';
import '../shared/app_style.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _wishlistBox = Hive.box("wishlist");

  _deleteWishlist(int key) async{
    await _wishlistBox.delete(key);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> wishlists = [];
    final wishListdata = _wishlistBox.keys.map((key){
      final shoe = _wishlistBox.get(key);
      return{
        "key": key,
        "id": shoe['id'],
        "name": shoe['name'],
        "category": shoe['category'],
        "price": shoe['price'],
        "imageUrl": shoe["imageUrl"]
      };
    }).toList();
    wishlists = wishListdata.reversed.toList();

    return Scaffold(
      body: SizedBox(
        width:MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width:MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/adidasOne.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    "My Wishlist",
                    style: appStyle(40, Colors.white, FontWeight.bold),
                  ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: wishlists.length,
                    padding: const EdgeInsets.only(top: 100),
                    itemBuilder: (BuildContext context, int index){
                      final shoe = wishlists[index];
                      return Padding(padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width,
                            decoration:const BoxDecoration(
                              color: Color(0XFFEBEEEF)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(padding: const EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: shoe['imageUrl'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                    ),
                                    Padding(padding: const EdgeInsets.only(top: 12, left: 20),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "shoe['name']",
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
                                              "\$${shoe['price']}",
                                              style: appStyle(
                                                  18, Colors.black, FontWeight.bold),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: ()async{
                                      _deleteWishlist(shoe['key']);
                                      ids.removeWhere((element) => element == shoe['id']);

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
            )
          ],
        ),
      )
    );
  }
}
