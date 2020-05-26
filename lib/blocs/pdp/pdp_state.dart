import 'package:anylearn/blocs/pdp/pdp_blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dto/pdp_dto.dart';

abstract class PdpState extends Equatable {
  const PdpState();
  @override
  List<Object> get props => [];
}

class PdpInitState extends PdpState {}

class PdpLoadingState extends PdpState {}

class PdpSuccessState extends PdpState {
  final PdpDTO data;
  PdpSuccessState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class PdpFavoriteAddState extends PdpState {
  final PdpDTO data;
  PdpFavoriteAddState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class PdpFavoriteRemoveState extends PdpState {
  final PdpDTO data;
  PdpFavoriteRemoveState({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => [data];
}

class PdpFailState extends PdpState {
  final String error;
  const PdpFailState({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => '{error: $error}';
}
