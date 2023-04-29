import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/common/helpers/constants.dart';
import 'package:firebase_app/firebase_ref/references.dart';
import 'package:firebase_app/screens/home/logic/states.dart';
import 'package:firebase_app/screens/login/student_login_screen.dart';
import 'package:firebase_app/services/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/helpers/cache_helper.dart';
import '../../../models/question_paper_model.dart';
import '../../../models/student_model.dart';
import 'package:flutter/material.dart';

import '../../qeustions/questions_screen.dart';

class QuizAppCubit extends Cubit<QuizAppStates> {
  QuizAppCubit() : super(QuizAppInitialState());

  static QuizAppCubit get(context) => BlocProvider.of(context);

UserModel? userModel;

  Stream<List<UserModel>> getUserData() {
   return
       FirebaseFirestore.instance.collection('users').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromJson(doc.data()))
              .toList());
  }

  getRole(){
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.clearData('uId');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentLoginScreen(),
          ),
          (route) => false);
      emit(QuizAppSignOutSuccessState());
    }).catchError((e) {
      emit(QuizAppSignOutErrorState(e));
    });
  }

  final allPapersImages = <String>[];
  final allPapers = <QuestionPaperModel>[];

  Future<void> get getAllPapers async {
    emit(GetAllPapersLoadingState());
    // List<String> imgName = ['biology', 'chemistry', 'math'];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.addAll(paperList);
      for (var paper in paperList) {
        final imgUrl =
            await FirebaseStorageService().getImage(paper.title.toLowerCase());
        paper.imageUrl = imgUrl!;
        // allPapers.addAll(paperList);
        emit(GetAllPapersSuccessState());
      }
    } catch (e) {
      print(e);
      emit(GetAllPapersErrorState(e.toString()));
    }
  }
}
