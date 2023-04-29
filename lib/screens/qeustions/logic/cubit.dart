import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/common/widgets/toast_widget.dart';
import 'package:firebase_app/firebase_ref/references.dart';
import 'package:firebase_app/models/question_paper_model.dart';
import 'package:firebase_app/screens/home/home_screen.dart';
import 'package:firebase_app/screens/qeustions/logic/states.dart';
import 'package:firebase_app/screens/register/logic/cubit.dart';
import 'package:firebase_app/screens/results/results_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/cache_helper.dart';
import '../../../common/helpers/constants.dart';
import '../../../models/student_model.dart';
import '../../login/logic/cubit.dart';

class QuestionsCubit extends Cubit<QuestionsStates> {
  QuestionsCubit(this.questionPaperModel) : super(QuestionsInitialState());

  static QuestionsCubit get(context) => BlocProvider.of(context);

  QuestionPaperModel? questionPaperModel;
  late Questions currentQuestion;

  void getQuestions(context) {
    // print('...loaded....');
    loadData(questionPaperModel!, context);
  }

  final allQuestions = <Questions>[];

  Future<void> loadData(QuestionPaperModel questionPaper, context) async {
    questionPaperModel = questionPaper;
    try {
      emit(QuestionsLoadingState());
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection('questions')
              .get();
      // print('query snapshot is => ');
      final questions = querySnapshot.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();
      // print(questions);
      questionPaper.questions = questions;
      for (Questions question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection('questions')
                .doc(question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answers) => Answers.fromSnapshot(answers))
            .toList();
        // print('answers is ${answers}');
        question.answers = answers;
      }
      emit(QuestionsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(QuestionsErrorState());
    }
    //out of try clause to be built just once otherwise this will be built five times
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.addAll(questionPaper.questions!);
      currentQuestion = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds, context);
      // print('...start timer...');
      // print(questionPaperModel.questions![0].question);
    }
  }

  void selectedAnswers(String? answer) {
    currentQuestion.selectedAnswer = answer;
    emit(AnswerChangeIndexSuccessStateState());
  }

  bool showResult = false;
  void submit(context) {
    _timer!.cancel();
    showResult = true;
    _saveTestResults(context);
    emit(GetResultSuccessState());
  }

  //for navigation between questions
  int questionIndex = 0;

  bool get isFirstQuestion => questionIndex > 0;

  bool get isLastQuestion => questionIndex < questionPaperModel!.questionCount;

  void get nextQuestion {
    if (questionIndex >= allQuestions.length - 1) return;
    questionIndex++;
    currentQuestion = allQuestions[questionIndex];
    emit(NextQuestionState());
  }

  void get previousQuestion {
    if (questionIndex <= 0) return;
    questionIndex--;
    currentQuestion = allQuestions[questionIndex];
    emit(PreviousQuestionState());
  }

  //for timer
  Timer? _timer;
  int remainSeconds = 1;
  String time = '00.00';

  _startTimer(int seconds, BuildContext context) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      if (remainSeconds == 0) {
        submit(context);
        emit(TimerEndedState());
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainSeconds--;
      }
      emit(TimerCountDownState());
    });
  }

  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions =>
      '$correctQuestionCount out of ${allQuestions.length} are correct';

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel!.timeSeconds - remainSeconds) /
        questionPaperModel!.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> _saveTestResults(context) async{
    var batch = fireStore.batch();
    User? user = BlocProvider.of<StudentQuizRegisterCubit>(context).userProfile;
    print(user?.email);
    if (user?.uid == null) return;
    batch.set(
        fireStore
            .collection('users')
            .doc(user!.email)
            .collection('recent_tests')
            .doc(questionPaperModel!.id),
        {
          'points' : points,
          'correct_answer':'$correctQuestionCount/${allQuestions.length}',
          'question_id':questionPaperModel!.id,
          'time':questionPaperModel!.timeSeconds- remainSeconds,
        });
    batch.commit();
    emit(SaveTestResults());
  }
}
