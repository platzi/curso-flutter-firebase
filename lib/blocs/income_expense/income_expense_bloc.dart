import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_event.dart';
import 'package:personal_finance/blocs/income_expense/income_expense_state.dart';
import 'package:personal_finance/repositories/income_expense_repository.dart';

class IncomeExpenseBloc extends Bloc<IncomeExpenseEvent, IncomeExpenseState> {
  final IncomeExpenseRepository repository;

  IncomeExpenseBloc(this.repository) : super(TransactionLoading()) {
    on<LoadTransactions>((event, emit) async {
      try {
        emit(TransactionLoading());
        final transactions = await repository.fetchTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Error loading transacion: $e'));
      }
    });
  }
}