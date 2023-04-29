import 'package:firebase_app/common/widgets/background_decoration_widget.dart';
import 'package:firebase_app/common/widgets/content_area_widget.dart';
import 'package:firebase_app/common/widgets/custom_app_bar.dart';
import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/screens/qeustions/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = QuestionsCubit.get(context);
    return Scaffold(
      body: BackgroundDecorationWidget(
        child: Column(
          children: [
            CustomAppBar(
              leading: SizedBox(
                height: 80.h,
              ),
              title: cubit.correctAnsweredQuestions,
            ),
            Expanded(
                child: ContentAreaWidget(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/img.png',
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 5),
                    child: Text(
                      'Congratulations',
                      style: LightTheme.cartTitles
                          .copyWith(color: primaryRedColor, fontSize: 20.sp),
                    ),
                  ),
                  Text(
                    'You have ${cubit.points} points',
                    style: const TextStyle(color: primaryRedColor),
                  ),
                  SizedBox(height: 25.h,),
                  // TextButton(onPressed: ()=> cubit.saveTestResults(context), child: const Text('Save To Firebase'))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
