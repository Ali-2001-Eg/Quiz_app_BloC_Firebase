import 'package:firebase_app/models/student_model.dart';
import 'package:firebase_app/screens/home/home_screen.dart';
import 'package:firebase_app/screens/login/logic/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helpers/cache_helper.dart';
import '../../register/logic/cubit.dart';

class StudentQuizLoginCubit extends Cubit<StudentQuizLoginState> {
  //required
  StudentQuizLoginCubit() : super(StudentQuizLoginInitialState());
  //to have object of the cubit
  static StudentQuizLoginCubit get(context) => BlocProvider.of(context);

  void studentLogin(
      {required String email, required String password, context}) {
    emit(StudentQuizLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider<StudentQuizRegisterCubit>.value(
                value: StudentQuizRegisterCubit(),
                child: const StudentHomeScreen(),
              )
          ),
              (route) => false);

      emit(StudentQuizLoginSuccessState(
          value.user!.email!));
    }).catchError((e) {
      print(e.toString());
      emit(StudentQuizLoginErrorState(e.toString()));
    });
  }


  UserModel? studentModel;
  bool isPasswordShown = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changeSuffixAndObscureText() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    emit(StudentQuizLoginChangingSuffixState());
  }
}
