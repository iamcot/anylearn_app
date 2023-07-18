part of transactionbloc;

abstract class TransactionState extends Equatable {
  const TransactionState();
  @override
  List<Object> get props => [];
}

class TransactionInitState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionConfigSuccessState extends TransactionState {
  final TransactionConfigDTO configs;
  const TransactionConfigSuccessState({required this.configs});
  @override
  List<Object> get props => [configs];
}

class TransactionHistoryLoadingState extends TransactionState {}

class TransactionHistorySuccessState extends TransactionState {
  final Map<String, List<TransactionDTO>> history;

  TransactionHistorySuccessState({required this.history});
  @override
  List<Object> get props => [history];
}

class TransactionWithdrawSavingState extends TransactionState {}

class TransactionWithdrawSaveSuccessState extends TransactionState {
  TransactionWithdrawSaveSuccessState();
  @override
  List<Object> get props => [];
}

class FoundationLoadingState extends TransactionState {}

class FoundationSuccessState extends TransactionState {
  final FoundationDTO value;

  FoundationSuccessState({required this.value});
  @override
  List<Object> get props => [value];
}

class TransactionDepositavingState extends TransactionState {}

class TransactionDepositeSaveSuccessState extends TransactionState {
  // final TransactionConfigDTO configs;

  // TransactionDepositeSaveSuccessState({this.configs});
  // @override
  // List<Object> get props => [configs];
}

class TransactionExchangeSavingState extends TransactionState {}

class TransactionExchangeSaveSuccessState extends TransactionState {
  TransactionExchangeSaveSuccessState();
  @override
  List<Object> get props => [];
}

class TransactionSaveFailState extends TransactionState {
  final String error;
  const TransactionSaveFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}

class TransactionFailState extends TransactionState {
  final String error;
  const TransactionFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
