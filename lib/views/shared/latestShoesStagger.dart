import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shoe_app/views/shared/staggerTile.dart';

import '../../models/shoeModel.dart';

class LatestShoesStagger extends StatelessWidget {
  const LatestShoesStagger({
    super.key,
    required Future<List<Shoe>> shoes,
  }) : _shoes = shoes;

  final Future<List<Shoe>> _shoes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Shoe>>(
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
          return StaggeredGridView.countBuilder(
              itemCount: mens!.length,
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              staggeredTileBuilder: (index)=> StaggeredTile.extent(
                  (index % 2 == 0)? 1: 1, (index % 4 == 1 || index % 4 ==3)
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.32
              ),
              itemBuilder: (context, index){
                final shoe = snapshot.data![index];
                return StaggerTile(
                    imageUrl: shoe.imageUrl[1],
                    name: shoe.name,
                    price: shoe.price);
              }

          );
        }
      },
    );
  }
}