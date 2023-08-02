import 'package:anylearn/dto/item_dto.dart';
import 'package:anylearn/dto/user_dto.dart';
import 'package:anylearn/dto/v3/voucher_dto.dart';
import 'package:equatable/equatable.dart';

class PartnerDTO extends Equatable {
  final partner;
  final sumRating;
  final sumReviews;
  final hotItems;
  final normalItems;
  final reviews;
  final vouchers;

  const PartnerDTO({
    this.partner,
    this.sumRating,
    this.sumReviews,
    this.hotItems,
    this.normalItems,
    this.reviews,
    this.vouchers
  });

  @override
  List<Object> get props => [
    partner,
    sumRating,
    sumReviews,
    hotItems,
    normalItems,
    reviews,
    vouchers,
  ];

  factory PartnerDTO.fromJson(dynamic json) {
    return  json == null || json.isEmpty 
      ? PartnerDTO(
          partner: '', 
          sumRating: 0, 
          sumReviews: 0,
          hotItems: [],
          normalItems: [],
          reviews: [],
          vouchers: []
        )
      : PartnerDTO(
        partner: json['partner'] == null
          ? UserDTO()
          : UserDTO.fromJson(json['partner']),
        sumRating: json['sumRating'] ?? 0,
        sumReviews: json['sumReviews'] ?? 0,
        hotItems: json['hotItems'] == null 
          ? []
          : List<ItemDTO>.from(json['hotItems']?.map((v) => v == null ? null : ItemDTO.fromJson(v))),
        normalItems: json['normalItems'] == null 
          ? []
          : List<ItemDTO>.from(json['normalItems']?.map((v) => v == null ? null : ItemDTO.fromJson(v))),
        reviews: json['reviews'] == null 
          ? [] 
          : List<ReviewDTO>.from(json['reviews']?.map((v) => v == null ? null : ReviewDTO.fromJson(v))),
        vouchers: json['vouchers'] == null 
          ?[]
          : List<VoucherDTO>.from(json['reviews']?.map((v) => v == null ? null : VoucherDTO.fromJson(v))),
      );
  }
}

class ReviewDTO extends Equatable {
  final id;
  final name;
  final content;
  final value;
  final createdAt;
  
  const ReviewDTO({
    this.id,
    this.name,
    this.content,
    this.value,
    this.createdAt,
  });

  @override
  List<Object> get props => [
    id,
    name,
    content,
    value,
    createdAt,
  ];

  factory ReviewDTO.fromJson(dynamic json) {
    return json == null 
      ? ReviewDTO()
      : ReviewDTO(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        content: json['extra_value'] ?? '',
        value: json['value'] ?? '',
        createdAt: json['created_at'] ?? '',
      );
  }
}