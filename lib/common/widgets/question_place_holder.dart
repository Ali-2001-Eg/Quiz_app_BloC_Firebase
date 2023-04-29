import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class QuestionPlaceHolder extends StatelessWidget {
  const QuestionPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lines = Container(
      width: double.infinity,
      height: 12.h,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    var answers = Container(
      width: double.infinity,
      height: 50.h,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
    return Shimmer.fromColors(
      baseColor:Colors.white,
      highlightColor:Colors.blueGrey.withOpacity(0.5),
      child: EasySeparatedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        separatorBuilder: (context, index) => SizedBox(height: 20.h,),
        children: [
          EasySeparatedColumn(children: [
            lines,
            lines,
            lines,
            lines,
          ], separatorBuilder: (context, index) => SizedBox(height: 10.h,),),
          answers,
          answers,
          answers,
        ],
      ),
    );
  }
}
