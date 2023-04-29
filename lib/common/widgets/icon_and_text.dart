import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({Key? key, required this.icon, required this.text}) : super(key: key);
  final Icon icon;
  final Widget text;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 4.w,),
        text,
      ],
    );
  }
}
