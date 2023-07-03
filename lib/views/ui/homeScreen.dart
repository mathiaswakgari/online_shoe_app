import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/adidasOne.png'),
                  fit: BoxFit.fill
              )
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("adidas", style: appStyleTwo(
              //     52,
              //     1.5,
              //     Colors.white,
              //     FontWeight.bold),),
              // Text("Shoe Collection", style: appStyleTwo(
              //     42,
              //     1.2,
              //     Colors.white,
              //     FontWeight.bold),),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.165),
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.365),
            child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.375,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
                                child: Container(
                                  color: Colors.grey[200],
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: CachedNetworkImage(
                                      imageUrl: "https://2app.kicksonfire.com/kofapp/upload/events_master_images/ipad_parley-x-adidas-forum-mid-wonder-white.png"),
                                ),
                              );
                            }

                        ),

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
                                    Text(
                                        "Show All",
                                        style: appStyle(22, Colors.black, FontWeight.w500),
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
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8.0),
                                child: Container(
                                  decoration:  BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  child: CachedNetworkImage(
                                      imageUrl: "https://cdn.shopify.com/s/files/1/0672/3039/products/1513905dc542bee2a70ae1d246595d60a1b9eb2c_1200x.png?v=1629255240"),
                                      
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.375,
                        color: Colors.cyanAccent,
                      )
                    ],
                  )
                ]


            ),
          ),


        ],

      ),
      )
    );
  }
}
