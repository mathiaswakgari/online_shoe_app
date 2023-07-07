import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

import '../shared/app_style.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final _cartBox = Hive.box("cart");


  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final shoe = _cartBox.get(key);
      return {
        "key": key,
        "id": shoe['id'],
        "category": shoe['category'],
        "name": shoe['name'],
        "imageUrl": shoe['imageUrl'],
        "price": shoe['price'],
        "sizes": shoe['sizes'],
        "qty": shoe['qty'],
      };
    }).toList();

    cart = cartData.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      },
                    child: const Icon(Icons.cancel_outlined, color: Colors.black,),
                  ),
                  Text(
                      "My Cart",
                      style: appStyle(36, Colors.black, FontWeight.bold,),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                        itemCount: cart.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index){
                          final data = cart[index];
                          print(data['sizes']);
                          final filteredSizes = data['sizes'].firstWhere((sizes)=>
                          sizes['isSelected'] == true
                          );
                          print(filteredSizes);

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
                                          onPressed: (context){},
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
                                                    Text(
                                                      data['name'],
                                                      style: appStyle(16, Colors.black, FontWeight.bold),
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
                                            )
                                          ],
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
              )
            ],
          ),
      )
    );
  }
}
