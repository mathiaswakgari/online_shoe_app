import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/views/shared/productCard.dart';
import 'package:online_shoe_app/views/ui/productCatagory.dart';
import 'package:online_shoe_app/views/ui/productScreen.dart';
import 'package:provider/provider.dart';

import '../../models/shoeModel.dart';
import 'LatestShoes.dart';
import 'app_style.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Shoe>> shoes, required this.tabIndex,
  }) : _shoes = shoes;

  final Future<List<Shoe>> _shoes;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductScreenNotifier>(context);
    return Column(
      children: [
        SizedBox(
            height: 284.h,
            child: FutureBuilder<List<Shoe>>(
              future: _shoes,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                }
                else{
                  final mens = snapshot.data;
                  return ListView.builder(
                      itemCount: mens!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        final shoe = snapshot.data![index];
                        return GestureDetector(
                          onTap: (){
                            productNotifier.selectedSizes = shoe.sizes;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context)=>ProductScreen(shoe: shoe)
                                )
                            );
                          },
                          child: ShoeCard(
                              price: "\$${shoe.price}",
                              category: shoe.category,
                              id: shoe.id,
                              name: shoe.name,
                              image: shoe.imageUrl[0]
                          ),
                        );
                      }

                  );
                }
              },
            )

        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest",
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context)=> ProductCategory(
                                    tabIndex: tabIndex
                                  )
                              )
                          );
                        },
                        child: Text(
                          "Show All",
                          style: appStyle(22, Colors.black, FontWeight.w500),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 20.h,

                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: 81.2.h,
            child: FutureBuilder<List<Shoe>>(
              future: _shoes,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }
                else if(snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                }
                else{
                  final mens = snapshot.data;
                  return ListView.builder(
                      itemCount: mens!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        final shoe = snapshot.data![index];
                        return Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: LatestShoes(imageUrl: shoe.imageUrl[1]),
                        );
                      }

                  );
                }
              },
            )
        )
      ],
    );
  }
}