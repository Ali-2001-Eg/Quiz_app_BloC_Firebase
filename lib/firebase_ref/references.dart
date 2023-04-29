import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection('questionPapers');
final userRF = fireStore.collection('users');
//to make sub collection
DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRF.doc(paperId).collection('questions').doc(questionId);


Reference get firebaseStorage => FirebaseStorage.instance.ref();

