import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email, int age) async {
    await _firestore.collection('users').add({
      'name': name,
      'email': email,
      'age': age,
    });
  }

  // Future<List<Map<String, dynamic>>> getUser() async {
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore.collection('users').get();
  //     List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) {
  //       return {
  //         'name': doc['name'],
  //         'email': doc['email'],
  //         'age': doc['age'],
  //       };
  //     }).toList();
  //     return users;
  //   } catch (e) {
  //     print('Error in fetching users from database :${e.toString()}');
  //     return [];
  //   }
  // }

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((QuerySnapshot) {
      return QuerySnapshot.docs.map((doc) {
        return {
          'name': doc['name'],
          'email': doc['email'],
          'age': doc['age'],
        };
      }).toList();
    },);
  }
}
