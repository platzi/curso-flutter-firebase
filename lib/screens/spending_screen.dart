import 'package:flutter/material.dart';
import 'package:personal_finance/widgets/line_chart_widget.dart';
import '../widgets/budget_card.dart';
import '../widgets/category_list.dart';

class SpendingScreen extends StatelessWidget {
  const SpendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appBarTheme.foregroundColor,
      appBar: AppBar(
        title: const Text('My Spending'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: LineChartWidget(),
            ),
            SizedBox(height: 16),
            BudgetCard(
              title: "Budget for October",
              amount: "\$2,478",
              progress: 0.5,
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 3,
              child: CategoryList(),
            ),
          ],
        ),
      ),
    );
  }
}
