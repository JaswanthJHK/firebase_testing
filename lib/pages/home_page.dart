import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/pages/user_creation_page.dart';
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
                return  Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: UserTile(
                    text: user['name'] ,
                    subText: user['email'],
                    age: user['age'],
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
}
