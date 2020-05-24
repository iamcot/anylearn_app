import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class LoadList extends UsersEvent {
  final String type;
  final int page;
  final int pageSize;

  LoadList({@required this.type, this.page = 1, this.pageSize = 9999});

  @override
  List<Object> get props => [type];

  @override
  String toString() => 'UsersEvent LoadList  { type: $type, page: $page, pageSize: $pageSize}';
}
