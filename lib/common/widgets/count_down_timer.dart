import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({Key? key, this.color, required this.time}) : super(key: key);
  final Color? color ;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timer,color: color ??Theme.of(context).primaryColor,),
        SizedBox(width: 5.w,),
        Text(time,style: LightTheme.countDownTimer.copyWith(color: color),),
      ],
    );
  }
}
