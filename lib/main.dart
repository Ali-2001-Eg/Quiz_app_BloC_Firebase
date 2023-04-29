import 'package:firebase_app/common/helpers/cache_helper.dart';
import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/screens/home/logic/cubit.dart';
import 'package:firebase_app/screens/qeustions/logic/cubit.dart';
import 'package:firebase_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/helpers/constants.dart';
import 'models/question_paper_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  // CacheHelper.clearData('name');
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: LightTheme().buildLightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
