import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key,
      required this.text,
      required this.subText,
      required this.deleteOntap,
      required this.updateOntap,
      required this.age});
  final String text;
  final String subText;
  final int age;
  final void Function()? deleteOntap;
  final void Function()? updateOntap;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color subTextColor = Theme.of(context).colorScheme.tertiaryContainer;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Icon(
              Icons.person_outline,
              color: textColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Age : $age",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
                Text(
                  subText,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: updateOntap,
              icon: Icon(Icons.edit),
            ),
            const SizedBox(
              width: 25,
            ),
            IconButton(
              onPressed: deleteOntap,
              icon: Icon(
                Icons.delete_outline,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
