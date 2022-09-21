import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/user_dto.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {
  final UserDTO user;

  LoadHomeEvent({required this.user});
  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoadHomeEvent';
}

class LoadQuoteEvent extends HomeEvent {
  final url;

  LoadQuoteEvent({this.url});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoadQuoteEvent';
}

class LoadGuideEvent extends HomeEvent {
  final String path;

  LoadGuideEvent({required this.path});
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoadGuideEvent';
}

class UpdatePopupVersionEvent extends HomeEvent {
  final int version;

  UpdatePopupVersionEvent({required this.version});
  @override
  List<Object> get props => [version];
  @override
  String toString() => 'UpdatePopupVersionEvent: $version';
}
