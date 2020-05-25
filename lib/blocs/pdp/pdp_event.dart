import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PdpEvent extends Equatable {
  const PdpEvent();
}

class LoadPDPEvent extends PdpEvent {
  final int id;

  LoadPDPEvent({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'LoadPDPEvent  { id: $id}';
}
