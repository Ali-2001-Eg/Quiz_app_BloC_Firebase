import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  //from our json
  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) {
    return QuestionPaperModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      timeSeconds: json['time_seconds'],
      questionCount: 0,
      questions: (json['questions'] as List)
          .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  //from firebase fire store
  factory QuestionPaperModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return QuestionPaperModel(
        id: snapshot.id,
        title: snapshot.data()?['title'],
        imageUrl: snapshot.data()?['imageUrl'] ?? '',
        description: snapshot.data()?['description'],
        timeSeconds: snapshot.data()?['time_seconds'],
        questionCount: snapshot.data()?['questions_count'],
        questions:[]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['time_seconds'] = timeSeconds;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? question;
  List<Answers>? answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({this.id, this.question, this.answers, this.correctAnswer});

  //colon to initialize constructor before run
  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id= snapshot.id,
        answers = [],
        correctAnswer = snapshot.data()['correct_answer'],
        question = snapshot.data()['questions'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot.data()['identifier'],
        answer = snapshot.data()['Answer'];

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}
