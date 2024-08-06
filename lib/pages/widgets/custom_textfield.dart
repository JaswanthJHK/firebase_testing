import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
  });
  final String hintText;
  final Icon icon;
  final TextEditingController controller;
  // final bool showPassIcon;
  // final Icon showIcon;
//  final Function()? showTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondaryContainer),
          ),
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          filled: true,
          hintText: hintText,
          prefixIcon: icon,

          // suffixIcon: IconButton(onPressed: showTap, icon: showPassIcon),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
