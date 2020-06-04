import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/event_dto.dart';


abstract class EventState extends Equatable {
  const EventState();
  @override
  List<Object> get props => [];
}

class EventInitState extends EventState {}

class EventLoadingState extends EventState {}

class EventSuccessState extends EventState {
  final Map<DateTime, List<EventDTO>> data;
  EventSuccessState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class EventFailState extends EventState {
  final String error;
  const EventFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
