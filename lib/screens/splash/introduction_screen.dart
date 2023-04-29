import 'package:firebase_app/common/helpers/cache_helper.dart';
import 'package:firebase_app/screens/login/student_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/app_colors.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: mainGradientLight,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 65.h,
                color: Colors.amber,
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'This is a study app, you can use it as you want.if you understand how this works, you would be able to scale it',
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.h,
                  color: Colors.white
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              IconButton(
                  onPressed: () {
                    CacheHelper.saveData(key: 'intro', value: 'intro')
                        .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentLoginScreen(),
                            ),
                            (route) => false));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 20.h,

                  ))
            ],
          ),
        ),
      ),
    );
  }
}
