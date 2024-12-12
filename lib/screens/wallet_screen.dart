import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_list.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appBarTheme.foregroundColor,
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta de Balance
            const BalanceCard(
              title: 'Available Balance',
              amount: '\$3,578',
              subtitle: 'See details',
            ),
            const SizedBox(height: 16),

            // Lista de transacciones recientes
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: TransactionList(),
            ),
          ],
        ),
      ),
    );
  }
}
