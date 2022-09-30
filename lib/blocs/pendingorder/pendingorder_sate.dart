import 'package:equatable/equatable.dart';

import '../../dto/pending_order_dto.dart';

abstract class PendingOrderState extends Equatable {
  const PendingOrderState();
  @override
  List<Object> get props => [];
}

class PendingOrderInitState extends PendingOrderState {}

class PendingOrderLoadingState extends PendingOrderState {}

class PendingOrderConfigSuccessState extends PendingOrderState {
  final PendingOrderDTO configs;
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

