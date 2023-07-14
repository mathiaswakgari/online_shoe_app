import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/views/shared/categoryButton.dart';
import 'package:online_shoe_app/views/shared/customSpace.dart';
import 'package:online_shoe_app/views/shared/staggerTile.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {

    final productNotifier = Provider.of<ProductScreenNotifier>(context);
    productNotifier.getWomens();
    productNotifier.getMens();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: 812.h,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
                height: (812 * 0.4).h,
                width: 375.w,
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
                        padding: EdgeInsets.fromLTRB(6.w, 12.h, 16.w, 18.h),
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
                padding: EdgeInsets.only(
                    top: (812 * 0.055).h, left: 20.w),
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
                    top: (812 * 0.285).h, left: 20.w, right: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.h)),
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        LatestShoesStagger(shoes: productNotifier.mens),
                        LatestShoesStagger(shoes: productNotifier.womens)
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
          height: (812 * 0.82).h,
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.h),
              topLeft: Radius.circular(25.h),
            )
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 5.h,
                width: 40.w,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.h)),
                  color: Colors.black38
                ),
              ),

              SizedBox(
                height:(812 * 0.7).h,
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


