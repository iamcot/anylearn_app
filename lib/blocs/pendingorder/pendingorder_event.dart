import 'package:anylearn/dto/user_dto.dart';
import 'package:equatable/equatable.dart';

abstract class PendingOrderEvent extends Equatable {
  const PendingOrderEvent();
}

class LoadPendingorderPageEvent extends PendingOrderEvent {
  final int id;
  final int userId;

  LoadPendingorderPageEvent({required this.id, required this.userId});
  @override
  List<Object> get props => [userId , id ];

  @override
  String toString() => 'LoadPendingorderPageEvent {user: $userId, id: $id}';
}
