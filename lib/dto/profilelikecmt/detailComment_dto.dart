

import 'dart:convert';

import 'package:anylearn/dto/profilelikecmt/action_dto.dart';
import 'package:anylearn/dto/user_dto.dart';



class DetailComment {
    DetailComment({
        this.id= 0,
        this.type = "",
        this.refId= 0,
        this.userId=0,
        this.postId,
        this.content,
        this.image="",
        this.day,
        this.status=0,
        this.createdAt,
        this.updatedAt,
        this.title= "",
        this.description="",
        this.likeCounts = 0,
        this.shareCounts = 0,
        this.user,
        this.comments,
        this.like,
    });

    int? id;
    String? type;
    int? refId;
    int? userId;
    dynamic postId;
    dynamic content;
    String? image;
    DateTime? day;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? title;
    String? description;
    int? likeCounts;
    int? shareCounts;
    UserDTO? user;
    final List<ActionDTO>? comments;
    final List<ActionDTO>? like;

    factory DetailComment.fromJson(Map<String, dynamic> json) => DetailComment(
        id: json["id"] ?? 0 ,
        type: json["type"] ?? "",
        refId: json["ref_id"] ?? 0,
        userId: json["user_id"] ?? 0,
        postId: json["post_id"],
        content: json["content"],
        image: json["image"] ?? "",
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        status: json["status"] ?? 0,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt:json['update_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        likeCounts: json["like_counts"] ?? 0,
        shareCounts: json["share_counts"] == null ? null : json["share_counts"],
        user: json['user'] == null ? UserDTO() : UserDTO.fromJson(json['user']),
        comments:  List<ActionDTO>.from(json['comments']
                ?.map((e) => e == null ? ActionDTO() : ActionDTO.fromJson(e)))
            .toList(),
        like: List<ActionDTO>.from(json['like']
            ?.map((e) => e == null ? null : ActionDTO.fromJson(e))).toList(),
    );

    
}


    

