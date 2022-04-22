import 'package:anylearn/dto/item_dto.dart';
import 'package:equatable/equatable.dart';

class UserCoursesDTO extends Equatable {
  final open;
  final close;

  UserCoursesDTO({this.open, this.close});

  @override
  List<Object> get props => [open, close];

  static UserCoursesDTO fromJson(dynamic json) {
    return json == ""
        ? UserCoursesDTO()
        : UserCoursesDTO(
            open: List<ItemDTO>.from(json['open']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
            close: List<ItemDTO>.from(json['close']?.map((v) => v == null ? null : ItemDTO.fromJson(v))).toList(),
          );
  }
}
