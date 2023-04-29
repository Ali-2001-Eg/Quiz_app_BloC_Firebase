
abstract class StudentQuizLoginState {}

class StudentQuizLoginInitialState extends StudentQuizLoginState {}

class StudentQuizLoginLoadingState extends StudentQuizLoginState {}

class StudentQuizLoginSuccessState extends StudentQuizLoginState {
  final String email;
  StudentQuizLoginSuccessState(this.email);
}

class StudentQuizLoginChangingSuffixState extends StudentQuizLoginState {}

class StudentQuizLoginErrorState extends StudentQuizLoginState {
  String error;
  StudentQuizLoginErrorState(this.error);
}