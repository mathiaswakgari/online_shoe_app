import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:online_shoe_app/controllers/cartScreenProvider.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../shared/app_style.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartScreenNotifier>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Consumer<CartScreenNotifier>(
        builder: (context, cartScreenNotifier, child){
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Cart Collection",
                      style: appStyle(36, Colors.black, FontWeight.bold,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: ListView.builder(
                          itemCount: cartProvider.cart.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index){
                            final data = cartProvider.cart[index];

                            final filteredSizes = data['sizes'].firstWhere((sizes)=>
                            sizes['isSelected'] == true
                            );
                            final filteredName = data['name'].substring(0, 15);

                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (context){
                                            cartProvider.deleteCart(data['key']);
                                            setState(() {
                                            });
                                          },
                                          backgroundColor: const Color(0xFF000000),
                                          foregroundColor: Colors.white,
                                          icon: CupertinoIcons.delete,
                                          label: "Delete",
                                        )
                                      ]),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.11,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEBEEEF),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade500,
                                            spreadRadius: 5,
                                            blurRadius: 0.3,
                                            offset: const Offset(0, 1)
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'],
                                                width: 70, height: 70, fit: BoxFit.fill,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 12, left: 20),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TextScroll(
                                                    filteredName,
                                                    style: appStyle(16, Colors.black, FontWeight.bold),
                                                    mode: TextScrollMode.bouncing,
                                                    velocity: const Velocity(pixelsPerSecond: Offset(150, 0)),
                                                    delayBefore: const Duration(milliseconds: 500),
                                                    numberOfReps: 5,
                                                    pauseBetween: const Duration(milliseconds: 50),
                                                    textAlign: TextAlign.right,
                                                    selectable: true,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(14, Colors.grey, FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "\$${data['price']}",
                                                        style: appStyle(15, Colors.black87, FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        "Size",
                                                        style: appStyle(18, Colors.grey, FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        filteredSizes['size'],
                                                        style: appStyle(18, Colors.grey, FontWeight.w600),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    color: Colors.grey,
                                                    child: const Icon(
                                                      CupertinoIcons.minus,
                                                      color: Colors.white,
                                                      size: 17,
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    cartScreenNotifier.subQuantity();
                                                  },

                                                ),
                                                Text(
                                                  cartScreenNotifier.quantity.toString(),
                                                  style: appStyle(
                                                      12,
                                                      Colors.black,
                                                      FontWeight.w600
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    color: Colors.black,
                                                    child: const Icon(
                                                      CupertinoIcons.plus,
                                                      color: Colors.white,
                                                      size: 17,
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    cartScreenNotifier.addQuantity();
                                                  },

                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                        ),
                        onPressed: ()async{
                        },
                        child: Text(
                          "Proceed to Checkout",
                          style: appStyle(18, Colors.white, FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
