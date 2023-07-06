import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shoe_app/controllers/productScreenProvider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductScreenNotifier>(
          builder: (context,productScreenNotifier ,child){
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leadingWidth: 0,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: const Icon(Icons.close, color: Colors.black,),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.ellipsis, color: Colors.black,),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  snap: false,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              controller: _pageController,
                              onPageChanged: (page){
                                productScreenNotifier.activePage = page;
                              },
                              itemBuilder: (context, int index){
                                return Stack(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.39,
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color(0XFFEBEEEF),
                                      child: CachedNetworkImage(imageUrl: "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/a832b860f78f4e80901baf1d017db635_9366/Retrocross_Spikeless_Golf_Shoes_White_GV6912_01_standard.jpg"),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height * 0.109,
                                      right: 20 ,
                                      child: const Icon(CupertinoIcons.heart),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        top: 200,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                              4, (index) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor: productScreenNotifier
                                                  .activePage == index ?
                                              Colors.black : Colors.grey,
                                            ) ,
                                          )),
                                        )

                                    )
                                  ],
                                );
                              }

                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
