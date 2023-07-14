import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12.h))
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