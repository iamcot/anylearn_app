import 'package:equatable/equatable.dart';

class NotificationDTO extends Equatable {
  final int id;
  final String title;
  final String content;
  final String read;
  final String route;
  final DateTime createdAt;
  final String extraContent;
  final String type;

  NotificationDTO({
    this.id,
    this.title,
    this.content,
    this.read,
    this.route,
    this.createdAt,
    this.extraContent,
    this.type,
  });

  @override
  List<Object> get props => [
        id,
        title,
        content,
        read,
        route,
        extraContent,
        type,
      ];

  static NotificationDTO fromJson(dynamic json) {
    return json == null
        ? null
        : NotificationDTO(
            id: json['id'],
            title: json['title'],
            content: json['content'],
            route: json['route'],
            read: json['read'],
            extraContent: json['extra_content'],
            createdAt: DateTime.parse(json['created_at']),
            type: json['type']
          );
  }
}

class NotificationPagingDTO extends Equatable {
  final currentPage;
  final List<NotificationDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  NotificationPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  static NotificationPagingDTO fromJson(dynamic json) {
    return json == null
        ? null
        : NotificationPagingDTO(
            currentPage: json['current_page'],
            data: List<NotificationDTO>.from(json['data']?.map((v) => v == null ? null : NotificationDTO.fromJson(v)))
                .toList(),
            // from: json['from'],
            // to: json['to'],
            perPage: json['per_page'],
            // lastPage: json['last_page'],
            total: json['total'],
          );
  }
}
