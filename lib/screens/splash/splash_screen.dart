import 'package:firebase_app/screens/splash/logic/cubit.dart';
import 'package:firebase_app/screens/splash/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/helpers/cache_helper.dart';
import '../../common/helpers/constants.dart';
import '../../config/themes/app_colors.dart';
import '../home/home_screen.dart';
import '../login/student_login_screen.dart';
import 'introduction_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initAuth(context),
      child: BlocConsumer<SplashCubit, SplashStates>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is InitAuthState) {

          }
        },
        builder: (context, state) {
          // print(state);
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: mainGradientLight,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/splash_logo.png',
                width: 200.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
