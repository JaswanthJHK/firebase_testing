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

  void partofReadData() async {
    // Retrieve a specific document
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc('documentId').get();
    // print('Name: ${documentSnapshot['name']}, Email: ${documentSnapshot['email']}, Age: ${documentSnapshot['age']}');
  }

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'email': doc['email'],
            'age': doc['age'],
          };
        }).toList();
      },
    );
  }

// _____________________________________update section_____________________________________
  Future<void> updateUserData(
    String name,
    int age,
    String documentId,
  ) async {
    // DocumentSnapshot document =
    //     await _firestore.collection('users').doc('documentId').get();
    // String docId = document.id;

    await _firestore.collection('users').doc(documentId).update({
      'name': name,
      'age': age,
    });
    print("main db funciton workin-=+++++++++++++------  :$name,$age");
  }

// _____________________________________delete section_____________________________________

  //  deleteUserData(String documentId)async {
  //   await _firestore.collection('users').doc('documentId').delete();
  // }

  Future<void> deleteUserData(String documentId) async {
    try {
      await _firestore.collection('users').doc(documentId).delete();
      print(
          'User with ID $documentId deleted successfully. in userData function......');
    } catch (e) {
      print('Error deleting user: ${e.toString()}');
    }
  }
}
