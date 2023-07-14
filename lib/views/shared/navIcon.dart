import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NavIcons extends StatelessWidget {

  final void Function()? onTap;
  final IconData? icon;

  const NavIcons({
    super.key,
    required this.onTap,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36.h,
        width: 36.w,
        child: Icon(icon, color: Colors.white,),
      ),
    );
  }
}