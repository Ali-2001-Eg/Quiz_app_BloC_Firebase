import 'package:firebase_app/screens/home/home_screen.dart';
import 'package:firebase_app/screens/login/logic/cubit.dart';
import 'package:firebase_app/screens/login/student_login_screen.dart';
import 'package:firebase_app/screens/splash/introduction_screen.dart';
import 'package:firebase_app/screens/splash/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/cache_helper.dart';
import '../../../common/helpers/constants.dart';
import '../../register/logic/cubit.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(InitAuthState());

  SplashCubit get(context) => BlocProvider.of(context);

  void initAuth(context) async {
    await Future.delayed(const Duration(seconds: 2));
    navigateToNextScreen(context);
    emit(NavigateToNextScreenState());
  }

  void navigateToNextScreen(context) {
    userName = CacheHelper.getData('name');
    // print(userName);
    if (userName != '') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider<StudentQuizRegisterCubit>.value(
              value: StudentQuizRegisterCubit(),
              child: const StudentHomeScreen(),
            )
          ),
          (route) => false);

    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AppIntroductionScreen(),
          ),
          (route) => false);
    }
  }
}
