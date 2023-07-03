import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navIcon.dart';

class BottomNavigation extends StatelessWidget {
  final mainScreenNotifier;

  const BottomNavigation({
    super.key,
    required this.mainScreenNotifier
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}