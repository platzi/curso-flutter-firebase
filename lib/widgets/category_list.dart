import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_state.dart';
import 'package:personal_finance/models/income_expense_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(onRefresh: () async {
      await Future.delayed(const Duration(seconds: 1));
    }, child: BlocBuilder<IncomeExpenseBloc, IncomeExpenseState>(builder: (context, state) {
      if (state is TransactionLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TransactionLoaded) {
        final categoryData = _calculateCategoryTotals(state.transactions);

        return ListView.builder(
            itemCount: categoryData.length,
            itemBuilder: (contex, index) {
              final category = categoryData.keys.elementAt(index);
              final total = categoryData[category];

              return Card(
                color: theme.primaryColorDark,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    category == 'income' ? 'Income' : 'Expense',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.appBarTheme.foregroundColor),
                  ),
                  trailing: Text(
                    '\$${total.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: theme.appBarTheme.foregroundColor,
                    ),
                  ),
                ),
              );
            });
      } else if (state is TransactionError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Center(child: Text('No transacion found'));
      }
    }));
  }

  Map<String, double> _calculateCategoryTotals(List<IncomeExpense> transactions) {
    final Map<String, double> categoryTotals = {'income': 0.0, 'expense': 0.0};

    for (final transaction in transactions) {
      final category = transaction.type;

      categoryTotals[category] = (categoryTotals[category] ?? 0) + transaction.amount;
    }
    return categoryTotals;
  }
}
