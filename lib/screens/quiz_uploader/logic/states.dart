abstract class QuizUploaderState{}

class QuizUploaderLoadingState extends QuizUploaderState{}

class QuizUploaderSuccessState extends QuizUploaderState{}

class QuizUploaderErrorState extends QuizUploaderState{
  final String error;

  QuizUploaderErrorState(this.error);
}