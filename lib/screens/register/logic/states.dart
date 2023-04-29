abstract class StudentQuizRegisterState {}

class StudentQuizRegisterInitialState extends StudentQuizRegisterState {}

class StudentQuizRegisterLoadingState extends StudentQuizRegisterState {}

class StudentQuizRegisterSuccessState extends StudentQuizRegisterState {}

class StudentQuizRegisterErrorState extends StudentQuizRegisterState {
  final String error;

  StudentQuizRegisterErrorState(this.error);
}

//new state to store credentials in fire store
class StudentQuizCreateUserSuccessState extends StudentQuizRegisterState {}

class StudentQuizCreateUserErrorState extends StudentQuizRegisterState {
  final String error;

  StudentQuizCreateUserErrorState(this.error);
}

class StudentQuizRegisterChangingSuffixState extends StudentQuizRegisterState {}

