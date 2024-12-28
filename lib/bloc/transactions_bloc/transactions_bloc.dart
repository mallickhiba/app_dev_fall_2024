import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/transaction_services.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionService transactionService;

  TransactionsBloc(this.transactionService) : super(TransactionsInitial()) {
    on<FetchTransactions>((event, emit) async {
      emit(TransactionsLoading());
      try {
        final transactions = await transactionService.fetchTransactions();
        emit(TransactionsLoaded(transactions));
      } catch (e) {
        emit(TransactionsError("Failed to fetch transactions: $e"));
      }
    });
  }
}
