import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance/models/income_expense_model.dart';

class IncomeExpenseRepository {
  final FirebaseFirestore _firestore;

  IncomeExpenseRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<IncomeExpense>> fetchTransactions() async {
    try {
      final querySnapshot = await _firestore.collection('transactions').get();
      return querySnapshot.docs.map((doc) {
        return IncomeExpense(
          id: doc.id,
          amount: doc["amount"],
          date: (doc["date"] as Timestamp).toDate(),
          description: doc["description"],
          type: doc["type"],
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }

  Future<void> addTransaction(IncomeExpense transaction) async {
    try {
      await _firestore.collection('transactions').add({
        "amount": transaction.amount,
        "description": transaction.description,
        "date": transaction.date,
        "type": transaction.type,
      });
    } catch (e) {
      throw Exception('Error adding transactions: $e');
    }
  }
}
