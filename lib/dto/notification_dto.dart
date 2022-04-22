import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationDTO extends Equatable {
  final id;
  final title;
  final content;
  final read;
  final route;
  final createdAt;
  final extraContent;
  final type;

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
    return json == ""
        ? NotificationDTO()
        : NotificationDTO(
            id: json['id'],
            title: json['title'],
            content: json['content'],
            route: json['route'],
            read: json['read'],
            extraContent: json['extra_content'],
            createdAt: DateTime.parse(json['created_at']),
            type: json['type']);
  }

  static NotificationDTO fromFireBase(RemoteMessage message) {
    // if (Platform.isIOS) {
    return NotificationDTO(
      title: message.notification?.title,
      content: message.notification?.body,
      route: message.data.containsKey("screen") ? message.data['screen'] : null,
      extraContent: message.data.containsKey("args") ? message.data['args'] : null,
    );
    // } else {
    //   return NotificationDTO(
    //     title: message.notification.title,
    //     content: message.notification.body,
    //     route: message.data['screen'] != null ? message.data['screen'] : null,
    //     extraContent: message.data['args'] != null ? message.data['args'] : null,
    //   );
    // }
  }

  static NotificationDTO fromNewFirebase(RemoteMessage message) {
    return NotificationDTO(
      title: message.notification?.title,
      content: message.notification?.body,
      route: message.data['screen'] != null ? message.data['screen'] : null,
      extraContent: message.data['args'] != null ? message.data['args'] : null,
    );
  }
}

class NotificationPagingDTO extends Equatable {
  final currentPage;
  final data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  NotificationPagingDTO({this.currentPage, this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  static NotificationPagingDTO fromJson(dynamic json) {
    return json == ""
        ? NotificationPagingDTO()
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
