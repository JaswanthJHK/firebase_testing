import 'package:firebase_testing/pages/widgets/custom_button.dart';
import 'package:firebase_testing/pages/widgets/custom_textfield.dart';
import 'package:firebase_testing/services/user_data_service.dart';
import 'package:flutter/material.dart';

class UserCreationPage extends StatefulWidget {
  UserCreationPage({super.key});

  @override
  State<UserCreationPage> createState() => _UserCreationPageState();
}

class _UserCreationPageState extends State<UserCreationPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  void addUserTofirebase() {
    final ageOfUser = int.tryParse(ageController.text);
    UserDataService()
        .addUser(nameController.text, emailController.text, ageOfUser!);
  }

  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text("A D D  U S E R"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  size: 150,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextfield(
                  hintText: "U S E R  N A M E",
                  icon: const Icon(Icons.person),
                  controller: nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  hintText: "U S E R  E M A I L",
                  icon: const Icon(Icons.person),
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  hintText: "U S E R  A G E",
                  icon: const Icon(Icons.person),
                  controller: ageController,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  ontap: () {
                    addUserTofirebase();
                    Navigator.pop(context);
                  },
                  buttonText: "A D D   U S E R ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
