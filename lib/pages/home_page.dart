import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/pages/user_creation_page.dart';
import 'package:firebase_testing/pages/widgets/custom_button.dart';
import 'package:firebase_testing/pages/widgets/custom_textfield.dart';
import 'package:firebase_testing/pages/widgets/user_tile.dart';
import 'package:firebase_testing/services/user_data_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserDataService userData = UserDataService();

  String seledctedUserId = '';

  void updateUserToFirebase() async {
    final newAge = int.tryParse(newAgeController.text);
    if (newAge != null && seledctedUserId.isNotEmpty) {
      await userData.updateUserData(
          newNameController.text, newAge, seledctedUserId);
      print(
          "update function in home screen is also working for user --------------: $seledctedUserId");
    } else {
      print("ivalid user data in home screen -------+++++--------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("H O M E"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[850],
      ),
      body: StreamBuilder(
        stream: userData.getUserStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error in homepage data : ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No users found in database"),
            );
          } else {
            final List<Map<String, dynamic>> users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserTile(
                    text: user['name'],
                    subText: user['email'],
                    age: user['age'],
                    deleteOntap: () => _deleteUser(user['id']),
                    updateOntap: () =>
                        updateUserBottomSheet(context, user['id']),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserCreationPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Function to delete a user and update the UI
  void _deleteUser(String documentId) async {
    if (documentId.isEmpty) {
      print("there is nothing in document id ====================");
    }
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete User"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await userData.deleteUserData(documentId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully! $documentId')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting user: ${e.toString()}')),
        );
      }
    }
  }

  final TextEditingController newNameController = TextEditingController();
  final TextEditingController newAgeController = TextEditingController();

  Future<dynamic> updateUserBottomSheet(BuildContext context, String userId) {
    seledctedUserId = userId;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.secondary,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust to fit content
              children: [
                const Text(
                  "U P D A T E  U S E R",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  hintText: "NEW NAME",
                  icon: const Icon(Icons.person),
                  controller: newNameController,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  hintText: "NEW AGE",
                  icon: const Icon(Icons.numbers),
                  controller: newAgeController,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  ontap: () {
                    print("ontap working ========");

                    updateUserToFirebase(); // Implement your update function
                    Navigator.pop(context);
                  },
                  buttonText: "UPDATE USER",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
