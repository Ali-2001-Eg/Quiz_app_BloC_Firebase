import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/screens/home/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/themes/app_colors.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(gradient: mainGradientLight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () =>
                  BlocProvider.of<QuizAppCubit>(context).signOut(context),
              title: Text(
                'Sign out',
                style: LightTheme.cartTitles.copyWith(color: Colors.white),
              ),
              leading: const Icon(Icons.logout, color: Colors.white),
              contentPadding: EdgeInsets.only(top: 20.h, left: 20.w),
              dense: true,
            ),
            ListTile(
              onTap: () => null,
              title: Text(
                'Quiz Results',
                style: LightTheme.cartTitles.copyWith(color: Colors.white),
              ),
              leading: const Icon(Icons.lightbulb_outline, color: Colors.white),
              contentPadding: EdgeInsets.only(top: 20.h, left: 20.w),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
