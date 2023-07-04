import 'package:flutter/material.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {Key? key,
        this.onPressed,
        required this.buttonColor,
        required this.label
      }) : super(key: key);
  final void Function()? onPressed;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Container(
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor, style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.all(Radius.circular(9))
        ),
          child: Center(child: Text(label, style: appStyle(20, buttonColor, FontWeight.w600),)),
    ),

    );
  }
}
