import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/transaction_repository.dart';

// States
abstract class TransactionState extends Equatable {
  const TransactionState();
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<dynamic> data; // Replace dynamic with your model later
  const TransactionSuccess(this.data);
  @override
  List<Object?> get props => [data];
}

class TransactionError extends TransactionState {
  final String message;
  const TransactionError(this.message);
  @override
  List<Object?> get props => [message];
}

// Cubit
class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repository;
  TransactionCubit(this.repository) : super(TransactionInitial());

  Future<void> fetchTransactions({String? query}) async {
    emit(TransactionLoading());
    try {
      final data = await repository.fetchTransactions(query: query);
      emit(TransactionSuccess(data));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
