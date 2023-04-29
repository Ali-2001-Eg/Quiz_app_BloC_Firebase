import 'package:firebase_app/config/themes/app_colors.dart';
import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: isSelected
              ? answerSelectedColor(context)
              : Theme.of(context).cardColor,
          border: Border.all(
            color:
                isSelected ? answerSelectedColor(context) : answerBorderColor,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
