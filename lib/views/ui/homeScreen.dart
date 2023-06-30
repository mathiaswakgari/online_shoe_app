import 'package:flutter/material.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home Screen",
          style: appStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}
