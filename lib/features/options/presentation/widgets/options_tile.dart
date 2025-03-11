import 'package:flutter/material.dart';

class OptionsTile extends StatelessWidget {
  final String title;
  final String goTo;
  const OptionsTile({super.key, required this.title, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 20,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      onTap: () => Navigator.pushNamed(context, goTo),
      trailing: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
