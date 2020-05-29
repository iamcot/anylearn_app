import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccChangeAvatarEvent extends AccountEvent {
  final File file;

  AccChangeAvatarEvent({this.file});
  @override
  List<Object> get props => [file];
  @override
  String toString() => 'AccChangeAvatarEvent $file';
}
