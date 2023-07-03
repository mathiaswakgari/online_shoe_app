import 'package:flutter/material.dart';

import '../shared/app_style.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Add Screen",
          style: appStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}
