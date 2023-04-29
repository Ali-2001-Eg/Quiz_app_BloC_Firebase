import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String phone;
  String uid;
  bool isProfessor;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
    required this.isProfessor,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        uid: json['uId'],
        isProfessor: json['isProfessor'],
      );

  UserModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        phone = snapshot.data()['phone'],
        uid = snapshot.data()['uId'],
        isProfessor = snapshot.data()['isProfessor'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'uId': uid,
        'isProfessor': isProfessor,
      };
}
