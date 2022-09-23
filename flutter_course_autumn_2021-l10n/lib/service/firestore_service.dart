import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course_autumn_2021/model/auth_model.dart';

class FireStoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> data = [];
    DocumentSnapshot myDoc = await firebaseFirestore
        .collection('local_users')
        .doc('b3gUnCQHsECbY89651ou')
        .get();

    data.add({
      'id': myDoc.id,
      'username': myDoc.get('username'),
      'password': myDoc.get('password')
    });
    return data;
  }

  void addUser(AuthModel authModel) {
    firebaseFirestore.collection('local_users').add(authModel.toJson());
  }
}
