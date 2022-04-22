import 'package:equatable/equatable.dart';

class ClassRegisteredUserDTO extends Equatable {
  final id;
  String name;
  String phone;
  String image;
  String child;

  ClassRegisteredUserDTO({
    this.id,
    this.name = "",
    this.phone = "",
    this.image = "",
    this.child = "",
  });

  @override
  List<Object> get props => [
        id,
        name,
        phone,
        image,
        child,
      ];

  @override
  String toString() => 'UserDTO {id: $id, name: $name, phone: $phone}';

  static ClassRegisteredUserDTO fromJson(dynamic json) {
    return json == ""
        ? ClassRegisteredUserDTO()
        : ClassRegisteredUserDTO(
            id: json['id'],
            name: json['name'],
            phone: json['phone'],
            image: json['image'],
            child: json['child'],
          );
  }
}
