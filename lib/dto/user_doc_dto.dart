import 'package:equatable/equatable.dart';

class UserDocDTO extends Equatable {
  final int id;
  final int userId;
  final String type;
  final String ext;
  final String data;

  UserDocDTO({this.id, this.userId, this.type, this.ext, this.data});

  @override
  List<Object> get props => [id, userId, type, ext, data];

  static UserDocDTO fromJson(dynamic json) {
    return json == null ? null : UserDocDTO(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      ext: json['file_ext'],
      data: json['data'],
    );
  }
  
}