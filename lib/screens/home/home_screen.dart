import 'dart:convert';

import 'package:firebase_app/common/helpers/cache_helper.dart';
import 'package:firebase_app/common/helpers/constants.dart';
import 'package:firebase_app/common/widgets/content_area_widget.dart';
import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:firebase_app/models/student_model.dart';
import 'package:firebase_app/screens/home/logic/cubit.dart';
import 'package:firebase_app/screens/home/logic/states.dart';
import 'package:firebase_app/screens/home/question_card.dart';
import 'package:firebase_app/screens/qeustions/logic/cubit.dart';
import 'package:firebase_app/screens/register/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets/menu_drawer.dart';
import '../../config/themes/app_colors.dart';
import '../login/logic/cubit.dart';
import '../login/student_login_screen.dart';
import '../qeustions/questions_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => QuizAppCubit()
        ..getUserData()
        ..getAllPapers,
      child: BlocConsumer<QuizAppCubit, QuizAppStates>(
        buildWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is QuizAppSignOutSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentLoginScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<QuizAppCubit>(context);
          // print(BlocProvider.of<StudentQuizRegisterCubit>(context).displayName);

          return Scaffold(
            // appBar: AppBar(
            //   actions: [
            //     IconButton(
            //         onPressed: () => Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => const QuizUploaderScreen(),
            //             )),
            //         icon: const Icon(Icons.upload))
            //   ],
            // ),
            key: scaffoldKey,
            drawer: const MenuDrawer(),
            body: StreamBuilder<List<UserModel>>(
                stream: cubit.getUserData(),
                builder: (context, snapshot) {
                  print(jsonEncode(
                      snapshot.data?.lastWhere((e) => e.isProfessor)));
                  print(CacheHelper.getData('name'));
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: mainGradientLight,
                    ),
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.only(bottom: 200),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //top menu
                          Padding(
                            padding: EdgeInsets.all(mobileScreenPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                IconButton(
                                  onPressed: () =>
                                      scaffoldKey.currentState!.openDrawer(),
                                  icon: Icon(
                                    Icons.menu,
                                    size: 20.h,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.handshake_outlined,
                                        size: 15.h,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                              text: 'Hello\t\t\t',
                                              style: LightTheme.detailsText
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 15.sp,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: BlocProvider.of<
                                                              StudentQuizRegisterCubit>(
                                                          context)
                                                      .displayName,
                                                  style: LightTheme.detailsText
                                                      .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.9),
                                                    fontSize: 25.sp,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'What do you want to learn today?',
                                  style: LightTheme.detailsText.copyWith(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                          //content area
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 12.h),
                            child: ContentAreaWidget(
                              addPadding: false,
                              child: ListView.separated(
                                itemCount: cubit.allPapers.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20.h),
                                shrinkWrap: true,
                                padding: UIParameters.mobileScreenPadding,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider<
                                                    StudentQuizRegisterCubit>.value(
                                                  value:
                                                      StudentQuizRegisterCubit(),
                                                  child: QuestionsScreen(
                                                      paper: cubit
                                                          .allPapers[index]),
                                                ))),
                                    child: QuestionCard(
                                      model: cubit.allPapers[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
