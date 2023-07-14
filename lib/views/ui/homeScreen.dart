import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:online_shoe_app/services/helper.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';
import 'package:online_shoe_app/views/shared/productCard.dart';
import 'package:online_shoe_app/models/shoeModel.dart';
import 'package:provider/provider.dart';

import '../shared/LatestShoes.dart';
import '../shared/homeWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);


  @override
  Widget build(BuildContext context) {
    final productNotifier = Provider.of<ProductScreenNotifier>(context);
    productNotifier.getMens();
    productNotifier.getWomens();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
      height: 812.h,
      width: 375.w,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 45.h, 0, 0),
            height: 330.h,
            width: 375.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/adidasOne.png'),
                  fit: BoxFit.fill
              )
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 133.98.h),
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
            ],
          ),

          ),

          Padding(
            padding: EdgeInsets.only(top: 296.38.h),
            child: TabBarView(
                controller: _tabController,
                children: [
                  HomeWidget(shoes: productNotifier.mens, tabIndex: 0,),
                  HomeWidget(shoes: productNotifier.womens, tabIndex: 1,),
                ]
            ),
          ),
        ],
      ),
      )
    );
  }
}



