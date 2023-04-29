import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/common/helpers/constants.dart';
import 'package:firebase_app/models/student_model.dart';
import 'package:firebase_app/screens/login/student_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/helpers/cache_helper.dart';
import 'states.dart';

class StudentQuizRegisterCubit extends Cubit<StudentQuizRegisterState> {
  StudentQuizRegisterCubit() : super(StudentQuizRegisterInitialState());
  static StudentQuizRegisterCubit get(context) => BlocProvider.of(context);

  void studentRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) {
    emit(StudentQuizRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      CacheHelper.saveData(key: 'name', value: name);

      studentCreate(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid,
      );
      emit(StudentQuizRegisterSuccessState());
    }).catchError((e) {
      emit(StudentQuizRegisterErrorState(e.toString()));
    });
  }
  var displayName = CacheHelper.getData('name');

  UserModel? studentModel;
  User? get userProfile => FirebaseAuth.instance.currentUser;
  void studentCreate({
    required String name,
    required String email,
    required String phone,
    required String uid,
  }) {
     studentModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      isProfessor: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(studentModel!.toJson())
        .then((value) {
      emit(StudentQuizCreateUserSuccessState());
    }).catchError((e) {
      emit(StudentQuizCreateUserErrorState(e.toString()));
    });
  }
  get getUserName => displayName;
  bool isPasswordShown = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changeSuffixAndObscureText() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    emit(StudentQuizRegisterChangingSuffixState());
  }
}
