import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeExpense {
  final String? id;
  final int amount;
  final String description;
  final DateTime date;
  final String type;

  IncomeExpense({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.type,
  });

  factory IncomeExpense.fromJson(Map<String, dynamic> json, {String? id}) {
    return IncomeExpense(
      id: id,
      amount: json['amount'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'description': description, 'date': date, 'type': type};
  }
}
