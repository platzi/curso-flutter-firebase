import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Número de transacciones simuladas
      itemBuilder: (context, index) {
        return TransactionItem(
          title: 'Transaction #$index',
          date: '10 Jan 2022',
          amount: '\$120.00',
          icon: Icons.shopping_bag,
        );
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final IconData icon;

  const TransactionItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.appBarTheme.foregroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight,
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          date,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
