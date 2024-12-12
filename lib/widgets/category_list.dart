import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          color: theme.primaryColorDark,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              'Shopping',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: theme.appBarTheme.foregroundColor,
                fontFamily: 'Roboto',
              ),
            ),
            subtitle: Text(
              '10 Jan 2022',
              style: theme.textTheme.bodySmall,
            ),
            trailing: Text(
              '\$54,417.80',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: theme.appBarTheme.foregroundColor,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        );
      },
    );
  }
}
