abstract class QuestionsStates{}

class QuestionsInitialState extends QuestionsStates{}

class QuestionsLoadingState extends QuestionsStates{}

class QuestionsSuccessState extends QuestionsStates{}

class QuestionsErrorState extends QuestionsStates{}

class AnswerChangeIndexSuccessStateState extends QuestionsStates{}

class NextQuestionState extends QuestionsStates{}

class PreviousQuestionState extends QuestionsStates{}

class TimerCountDownState extends QuestionsStates{}

class TimerEndedState extends QuestionsStates{}

class NavigateToResultsState extends QuestionsStates{}

class GetResultSuccessState extends QuestionsStates{}

class SaveTestResults extends QuestionsStates{}