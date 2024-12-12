import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final String title;
  final String amount;
  final String? subtitle;
  final double? progress;

  const BudgetCard({
    super.key,
    required this.title,
    required this.amount,
    this.subtitle,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.appBarTheme.foregroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: theme.textTheme.titleMedium,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
          if (progress != null) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: theme.primaryColor,
            ),
          ],
        ],
      ),
    );
  }
}
