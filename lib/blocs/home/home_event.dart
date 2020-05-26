import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {
  final String role;

  LoadHomeEvent({this.role});
  @override
  List<Object> get props => [role];

  @override
  String toString() => 'LoadHomeEvent';
}
