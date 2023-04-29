import 'package:firebase_app/common/widgets/answer_card.dart';
import 'package:firebase_app/common/widgets/background_decoration_widget.dart';
import 'package:firebase_app/common/widgets/content_area_widget.dart';
import 'package:firebase_app/common/widgets/count_down_timer.dart';
import 'package:firebase_app/common/widgets/custom_app_bar.dart';
import 'package:firebase_app/common/widgets/question_place_holder.dart';
import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:firebase_app/models/question_paper_model.dart';
import 'package:firebase_app/screens/qeustions/logic/cubit.dart';
import 'package:firebase_app/screens/qeustions/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../results/results_screen.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({Key? key, required this.paper}) : super(key: key);
  final QuestionPaperModel paper;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionsCubit>(
      create: (context) => QuestionsCubit(paper)..getQuestions(context),
      child: BlocConsumer<QuestionsCubit, QuestionsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = QuestionsCubit.get(context);
          // print(state);
          return cubit.showResult
              ? const ResultScreen()
              : Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: CustomAppBar(
                    leading: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: const ShapeDecoration(
                          shape: StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 2),
                      )),
                      child: CountDownTimer(
                        time: cubit.time,
                        color: Colors.white,
                      ),
                    ),
                    showSubmit: true,
                    titleWidget: Text(
                      'Q. ${(cubit.questionIndex + 1).toString().padLeft(2, '0')}',
                      style: LightTheme.appBarText,
                    ),
                    onSubmitTab: () => cubit.submit(context),
                  ),
                  body: (state is QuestionsLoadingState)
                      ? const BackgroundDecorationWidget(
                          child: QuestionPlaceHolder())
                      : BackgroundDecorationWidget(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40.h, horizontal: 10.w),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ContentAreaWidget(
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(top: 25.h),
                                      child: Column(
                                        children: [
                                          Text(
                                            cubit.currentQuestion.question!,
                                            style: questionTS,
                                          ),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(top: 25.h),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: cubit.currentQuestion
                                                .answers!.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 10.h,
                                            ),
                                            itemBuilder: (context, index) {
                                              final answers = cubit
                                                  .currentQuestion
                                                  .answers![index];
                                              return AnswerCard(
                                                answer:
                                                    '${answers.identifier}. ${answers.answer}',
                                                onTap: () =>
                                                    cubit.selectedAnswers(
                                                        answers.identifier),
                                                isSelected:
                                                    answers.identifier ==
                                                        cubit.currentQuestion
                                                            .selectedAnswer,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ColoredBox(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: UIParameters.mobileScreenPadding,
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: cubit.isFirstQuestion,
                                          child: Container(
                                            width: 55.w,
                                            height: 55.w,
                                            decoration: BoxDecoration(
                                              color: cardColor,
                                              borderRadius:
                                                  UIParameters.cardBorderRadius,
                                            ),
                                            child: IconButton(
                                              onPressed: () =>
                                                  cubit.previousQuestion,
                                              icon: Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Expanded(
                                          child: Visibility(
                                            visible: cubit.isLastQuestion,
                                            child: SizedBox(
                                              height: 55.h,
                                              child: InkWell(
                                                onTap: () {
                                                  cubit.nextQuestion;
                                                  print(cubit
                                                      .correctQuestionCount);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: cardColor,
                                                  ),
                                                  width: double.infinity,
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Center(
                                                      child: Text(
                                                        'Next',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                primaryRedColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                );
        },
      ),
    );
  }
}
