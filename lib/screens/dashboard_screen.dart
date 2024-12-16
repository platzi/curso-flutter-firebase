import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_state.dart';
import 'package:personal_finance/widgets/budget_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.white,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Dashboard'),
        ),
        child: BlocBuilder<IncomeExpenseBloc, IncomeExpenseState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is TransactionLoaded) {
              final totalIncome = state.transactions
                  .where((transaction) => transaction.type == 'income')
                  .fold<double>(0, (sum, transaction) => sum + transaction.amount);

              final totalExpense = state.transactions
                  .where((transaction) => transaction.type == 'expense')
                  .fold<double>(0, (sum, transaction) => sum + transaction.amount);

              final availableBalance = totalIncome - totalExpense;
              final budgetForMonth = totalIncome * 0.7;

              return Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  _buildBody(context, availableBalance, budgetForMonth, totalIncome, totalExpense),
                ],
              );
            } else if (state is TransactionError) {
              return Center(
                child: Text('Error loading data: ${state.message}'),
              );
            } else {
              return const Center(
                child: Text('No data available'),
              );
            }
          },
        ));
  }

  Widget _buildBody(BuildContext context, double availableBalance, double budget, double income, double expense) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [CupertinoColors.systemGreen, CupertinoColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7])),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance general
            _buildCustomCard(
              title: "Available balance",
              amount: "\$${availableBalance.toString()}",
              subtitle: "See details",
            ),
            const SizedBox(height: 16),

            // Presupuesto
            _buildCustomCard(
              title: "Budget for October",
              amount: "\$${budget.toString()}",
              subtitle: "Cash Available",
            ),
            const SizedBox(height: 16),

            // Botón de objetivo de ahorro
            CupertinoButton.filled(
              child: const Text('Create a Saving Goal'),
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            // Ingreso y gastos
            Row(
              children: [
                Expanded(
                  child: BudgetCard(
                    title: "Income",
                    amount: "\$${income.toString()}",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BudgetCard(
                    title: "Expense",
                    amount: "\$${expense.toString()}",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir tarjetas con diseño verde a la mitad
  Widget _buildCustomCard({
    required String title,
    required String amount,
    String? subtitle,
  }) {
    return Card(
      color: CupertinoColors.systemBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sección superior con el verde
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: CupertinoColors.systemGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Contenido inferior
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  selectionColor: CupertinoColors.systemGreen,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    selectionColor: CupertinoColors.opaqueSeparator,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
