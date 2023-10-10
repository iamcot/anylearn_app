import 'package:equatable/equatable.dart';
import 'package:anylearn/dto/item_dto.dart';

class ListingDTO extends Equatable {
  final numPage;
  final currentPage; 
  final searchResults;

  const ListingDTO({
    this.numPage,
    this.currentPage,
    this.searchResults,
  }); 

  @override 
  List<Object?> get props => [numPage, currentPage, searchResults];

  factory ListingDTO.fromJson(dynamic json) {
    return json == null || json.isEmpty
      ? ListingDTO(numPage: 1, currentPage: 1, searchResults: [])
      : ListingDTO(
        numPage: json['numPage'] ?? 1,
        currentPage: json['currentPage'] ?? 1,
        searchResults: json['searchResults'] == null 
          ? []
          : List<ListingResultDTO>.from(
            json['searchResults']?.map((v) => v == null ? null : ListingResultDTO.fromJson(v)),
          ),
      );
  }
}

class ListingResultDTO extends Equatable {
  final id;
  final name;
  final image;
  final items;

  const ListingResultDTO({this.id, this.name, this.image, this.items});
  
  @override
  List<Object?> get props => [id, name, image, items];

  factory ListingResultDTO.fromJson(dynamic json) {
    return json == null
      ? ListingResultDTO(id: 0, name: '', items: [])
      : ListingResultDTO(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        items: json['items'] == null 
          ? []
          : List<ItemDTO>.from(json['items']?.map((v) => v == null ? null : ItemDTO.fromJson(v)))
      ); 
  }
}