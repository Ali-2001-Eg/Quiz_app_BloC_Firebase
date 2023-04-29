abstract class QuizAppStates{}

class QuizAppInitialState extends QuizAppStates{}

class QuizAppLoadingState extends QuizAppStates{}

class QuizAppGetUserSuccessState extends QuizAppStates{}

class QuizAppGetUserErrorState extends QuizAppStates{
  final String error;
  QuizAppGetUserErrorState(this.error);
}
class QuizAppSignOutSuccessState extends QuizAppStates{}

class QuizAppSignOutErrorState extends QuizAppStates{
  final String error;
  QuizAppSignOutErrorState(this.error);
}

class GetAllPapersLoadingState extends QuizAppStates{}
class GetAllPapersSuccessState extends QuizAppStates{}

class GetAllPapersErrorState extends QuizAppStates{
  final String error;
  GetAllPapersErrorState(this.error);
}
