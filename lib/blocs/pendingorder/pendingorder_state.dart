part of pendingorderbloc;

abstract class PendingOrderState extends Equatable {
  const PendingOrderState();
  @override
  List<Object> get props => [];

  get load => null;
}

class PendingOrderInitState extends PendingOrderState {}

class PendingOrderLoadingState extends PendingOrderState {}

class PendingOrderConfigSuccessState extends PendingOrderState {
  final List<PendingOrderDTO> configs;
  const PendingOrderConfigSuccessState({required this.configs});
  @override
  List<Object> get props => [configs];
}

class PendingOrderFailState extends PendingOrderState {
  final String error;
  const PendingOrderFailState({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
