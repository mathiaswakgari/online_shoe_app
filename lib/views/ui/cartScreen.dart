import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.all(12.h),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Cart Collection",
                      style: appStyle(36, Colors.black, FontWeight.bold,),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: (812 * 0.65).h,
                      child:cartProvider.cart.isEmpty ?
                      SizedBox(
                        width: 375.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ooops, Your Cart",
                              style: appStyle(40, Colors.black, FontWeight.bold),
                            ),
                            Text(
                              "is Empty",
                              style: appStyle(40, Colors.black, FontWeight.bold),
                            ),
                          ],
                        ),
                      ):
                      ListView.builder(
                          itemCount: cartProvider.cart.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index){
                            final data = cartProvider.cart[index];

                            final filteredSizes = data['sizes'].firstWhere((sizes)=>
                              sizes['isSelected'] == true, orElse: ()=> null
                            );

                            print("filteredSizes: ${filteredSizes}");
                            final filteredName = data['name'].substring(0, 15);

                            return Padding(
                              padding: EdgeInsets.all(8.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.h),
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
                                    height: (812 * 0.11).h,
                                    width: 375.w,
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
                                              padding: EdgeInsets.all(12.h),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'],
                                                width: 70.w, height: 70.h, fit: BoxFit.fill,),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 12.h, left: 20.w),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: (375 * 0.52).w,
                                                    height: 25.h,
                                                    child: Text(
                                                      data['name'],
                                                      overflow: TextOverflow.ellipsis,
                                                      style: appStyle(16, Colors.black, FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(14, Colors.grey, FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "\$${data['price']}",
                                                        style: appStyle(15, Colors.black87, FontWeight.bold),
                                                      ),
                                                      SizedBox(
                                                        width: 20.w,
                                                      ),
                                                      Text(
                                                        "Size",
                                                        style: appStyle(18, Colors.grey, FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      Text(
                                                        filteredSizes != null ? filteredSizes['size'] : '6.0',
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
                                          padding: EdgeInsets.all(8.0.h),
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
                                                    child: Icon(
                                                      CupertinoIcons.minus,
                                                      color: Colors.white,
                                                      size: 17.h,
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
                                                    child: Icon(
                                                      CupertinoIcons.plus,
                                                      color: Colors.white,
                                                      size: 17.h,
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
                if(cartProvider.cart.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 375.w,
                      height: 50.h,
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                          ),
                          onPressed: (){
                          },
                          child: Text(
                            "Proceed to Checkout",
                            style: appStyle(18, Colors.white, FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 375.w,
                      height: 50.h,
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent
                          ),
                          onPressed: ()async{
                            await cartProvider.clearCart();
                            setState(() {
                            });
                          },
                          child: Text(
                            "Clear Cart",
                            style: appStyle(18, Colors.white, FontWeight.bold),
                          )),
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      )
    );
  }
}
