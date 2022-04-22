import 'package:equatable/equatable.dart';

class UserDocDTO extends Equatable {
  final id;
  final userId;
  final type;
  final ext;
  final data;

  UserDocDTO({this.id, this.userId, this.type, this.ext, this.data});

  @override
  List<Object> get props => [id, userId, type, ext, data];

  static UserDocDTO fromJson(dynamic json) {
    return json == "" ? UserDocDTO() : UserDocDTO(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      ext: json['file_ext'],
      data: json['data'],
    );
  }
  
}