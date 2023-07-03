import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shoe_app/controllers/mainScreenProvider.dart';
import 'package:online_shoe_app/views/shared/bottomNavigationBar.dart';
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
          bottomNavigationBar: BottomNavigation(
              mainScreenNotifier: mainScreenNotifier
          ),
        );
      },

    );
  }
}




