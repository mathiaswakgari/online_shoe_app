import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shoe_app/views/shared/categoryButton.dart';
import 'package:online_shoe_app/views/shared/customSpace.dart';
import 'package:online_shoe_app/views/shared/staggerTile.dart';

import '../../models/shoeModel.dart';
import '../../services/helper.dart';
import '../shared/app_style.dart';
import '../shared/latestShoesStagger.dart';

class ProductCategory extends StatefulWidget {
  final int tabIndex;

  const ProductCategory({Key? key, required this.tabIndex}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);

  late Future<List<Shoe>> _mens;
  late Future<List<Shoe>> _womens;


  void getMens(){
    _mens = Helper().getMens();
  }
  void getWomens(){
    _womens = Helper().getWomens();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMens();
    getWomens();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/adidasOne.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close_sharp, color: Colors.white,),
                          ),
                          GestureDetector(
                            onTap: (){
                              // Navigator.pop(context);
                              filter();
                            },
                            child: const Icon(Icons.settings, color: Colors.white,),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.055, left: 20),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,

                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(text: "Men Shoes",),
                      Tab(text: "Women Shoes",)
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.285, left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        LatestShoesStagger(shoes: _mens),
                        LatestShoesStagger(shoes: _womens)
                      ]


                  ),
                ),
              )
            ],


          ),
        ),
      ),
    );
  }

  Future<dynamic> filter(){
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context)=> Container(
          height: MediaQuery.of(context).size.height * 0.82,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            )
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const CustomSpace(),
                    Text("Filter", style: appStyle(40, Colors.black, FontWeight.bold),),
                    const CustomSpace(),
                    Text("Gender", style: appStyle(20, Colors.black, FontWeight.bold),),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CategoryButton(
                            buttonColor: Colors.black,
                            label: "Men"
                        ),
                        CategoryButton(
                            buttonColor: Colors.grey,
                            label: "Women"
                        ),
                      ],
                    ),
                    const CustomSpace(),
                    Text("Price",style: appStyle(20, Colors.black, FontWeight.bold),),
                    const CustomSpace(),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 200,
                        divisions: 100,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value){
                            _value = value;
                        }),
                    const CustomSpace()


                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}


