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
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: 0,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          NavIcons(
              icon: mainScreenNotifier.pageIndex == 0 ?
              Icons.home_filled : CupertinoIcons.home,
              onTap: (){
                mainScreenNotifier.pageIndex = 0;
              }),
          NavIcons(
              icon: mainScreenNotifier.pageIndex == 1 ?
              CupertinoIcons.cart_fill : CupertinoIcons
                  .cart,
              onTap: (){
                mainScreenNotifier.pageIndex = 1;
              }),
          NavIcons(
              icon: mainScreenNotifier.pageIndex == 2 ?
              CupertinoIcons.heart_fill : CupertinoIcons
                  .heart,
              onTap: (){
                mainScreenNotifier.pageIndex = 2;
              }),
        ],
      ),
    );
  }
}