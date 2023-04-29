
import '../firebase_ref/references.dart';


class FirebaseStorageService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) return null;
    try {
      final urlRef = firebaseStorage
          .child('question_paper_images')
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
