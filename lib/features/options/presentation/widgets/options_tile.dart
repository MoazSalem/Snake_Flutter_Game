import 'package:flutter/material.dart';
import 'package:snake/core/utils/app_sizes.dart';

class OptionsTile extends StatelessWidget {
  final String title;
  final String goTo;
  const OptionsTile({super.key, required this.title, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: AppSizes.verticalPadding,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
      title: Text(
        title,
        style: const TextStyle(fontSize: AppSizes.titleSize),
      ),
      onTap: () => Navigator.pushNamed(context, goTo),
      trailing: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
