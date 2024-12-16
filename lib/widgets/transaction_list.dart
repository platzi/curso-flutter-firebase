import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_event.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_state.dart';
import 'package:personal_finance/models/income_expense_model.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required List<IncomeExpense> transactions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomeExpenseBloc, IncomeExpenseState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TransactionLoaded) {
          final transactions = state.transactions;

          if (transactions.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return TransactionItem(
                title: transaction.description,
                date: transaction.date.toLocal().toString(),
                amount: '\$${transaction.amount.toStringAsFixed(2)}',
                icon: transaction.type == 'income' ? Icons.add : Icons.remove,
                onDelete: () {},
              );
            },
          );
        } else if (state is TransactionError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text('Unknown state.'));
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final IconData icon;
  //SOLO PARA EL ONDELETE
  final VoidCallback onDelete;

  const TransactionItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.icon,
    //SOLO PARA EL ON DELETE
    required this.onDelete,
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
