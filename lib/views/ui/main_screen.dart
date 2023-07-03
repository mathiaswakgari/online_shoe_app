import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shoe_app/controllers/mainScreenProvider.dart';
import 'package:online_shoe_app/views/ui/addScreen.dart';
import 'package:online_shoe_app/views/ui/cartScreen.dart';
import 'package:online_shoe_app/views/ui/homeScreen.dart';
import 'package:online_shoe_app/views/ui/profileScreen.dart';
import 'package:online_shoe_app/views/ui/searchScreen.dart';
import 'package:provider/provider.dart';

import '../shared/app_style.dart';
import '../shared/navIcon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  final List<Widget> pageList = const [
    HomeScreen(),
    CartScreen(),
    AddScreen(),
    ProfileScreen(),
    SearchScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child){
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    NavIcons(
                        icon: mainScreenNotifier.pageIndex == 0 ?
                        Icons.home_filled : CupertinoIcons.home,
                        onTap: (){
                        mainScreenNotifier.pageIndex = 0;
                    }),
                    NavIcons(
                        icon: mainScreenNotifier.pageIndex == 1 ?
                        CupertinoIcons.search_circle_fill : CupertinoIcons
                            .search_circle,
                        onTap: (){
                          mainScreenNotifier.pageIndex = 1;
                    }),
                    NavIcons(
                        icon: mainScreenNotifier.pageIndex == 2 ?
                        CupertinoIcons.add_circled_solid : CupertinoIcons
                            .add_circled,
                        onTap: (){
                          mainScreenNotifier.pageIndex = 2;
                    }),
                    NavIcons(
                        icon: mainScreenNotifier.pageIndex == 3 ?
                        CupertinoIcons.cart_fill : CupertinoIcons.cart,
                        onTap: (){
                          mainScreenNotifier.pageIndex = 3;
                    }),
                    NavIcons(
                        icon: mainScreenNotifier.pageIndex == 4 ?
                        CupertinoIcons.person_alt_circle_fill : CupertinoIcons
                            .person_alt_circle,
                        onTap: (){
                          mainScreenNotifier.pageIndex = 4;
                    }),
                  ],
                ),
              ),
            ),
          ),

        );
      },

    );
  }
}


