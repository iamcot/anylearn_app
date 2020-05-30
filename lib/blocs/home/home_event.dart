import 'package:equatable/equatable.dart';

import '../../dto/user_dto.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {
  final UserDTO user;

  LoadHomeEvent({this.user});
  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoadHomeEvent';
}

class LoadQuoteEvent extends HomeEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoadQuoteEvent';
}
