part of 'transactions_bloc.dart';

abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Map<String, dynamic>> transactions;
  TransactionsLoaded(this.transactions);
}

class TransactionsError extends TransactionsState {
  final String message;
  TransactionsError(this.message);
}
