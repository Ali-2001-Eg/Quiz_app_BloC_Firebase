import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/question_paper_model.dart';
import 'package:firebase_app/screens/quiz_uploader/logic/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase_ref/references.dart';

class QuizUploaderCubit extends Cubit<QuizUploaderState> {
  QuizUploaderCubit() : super(QuizUploaderLoadingState());
  QuizUploaderCubit get(context) => BlocProvider.of(context);

  Future<void> uploadData(BuildContext context) async {
    emit(QuizUploaderLoadingState());
    final fireStore = FirebaseFirestore.instance;
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //load json files and print paths
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/DB/papers') && path.contains('.json'))
        .toList();
    print(papersInAssets);
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
      // print(stringPaperContent);
    }
    // print(questionPapers[0].description);
    var batch = fireStore.batch();
    for (var paper in questionPapers) {
      //set to upload to fireStore and doc takes paper id
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        'description': paper.description,
        'time_seconds': paper.timeSeconds,
        'questions_count': paper.questions?.length ?? 0,
      });
      //to add questions set
      for (var question in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: question.id!);
        batch.set(questionPath, {
          'questions': question.question,
          // 'id':question.id,
          'correct_answer': question.correctAnswer,
        });
        for (var answer in question.answers!) {
          batch.set(questionPath.collection('answers').doc(answer.identifier), {
            "identifier": answer.identifier,
            'Answer': answer.answer,
          });
        }
      }
    }
    await batch
        .commit()
        .then((value) => emit(QuizUploaderSuccessState()))
        .catchError((e) {
      print(e.toString());
      emit(QuizUploaderErrorState(e.toString()));
    });
  }
}
