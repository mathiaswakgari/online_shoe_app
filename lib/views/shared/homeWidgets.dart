import 'package:flutter/material.dart';
import 'package:online_shoe_app/views/shared/productCard.dart';
import 'package:online_shoe_app/views/ui/productCatagory.dart';

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
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.350,
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
                        return ShoeCard(
                            price: "\$${shoe.price}",
                            category: shoe.category,
                            id: shoe.id,
                            name: shoe.name,
                            image: shoe.imageUrl[0]
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,

                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
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
                          padding: const EdgeInsets.only(left: 12.0),
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