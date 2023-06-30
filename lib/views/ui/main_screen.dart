import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/app_style.dart';
import '../shared/navIcon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),

      body: Center(
        child: Text(
            "MainScreen",
            style: appStyle(40, Colors.black, FontWeight.bold)
        ),
      ),

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
                NavIcons(icon:CupertinoIcons.home , onTap: (){}),
                NavIcons(icon:CupertinoIcons.search , onTap: (){}),
                NavIcons(icon:CupertinoIcons.add , onTap: (){}),
                NavIcons(icon:CupertinoIcons.cart , onTap: (){}),
                NavIcons(icon:CupertinoIcons.person , onTap: (){}),
              ],
            ),
          ),
        ),
      ),

    );
  }
}


