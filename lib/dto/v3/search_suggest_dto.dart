import 'package:equatable/equatable.dart';
import 'home_dto.dart';

class SearchSuggestDTO extends Equatable {
  final List<String> lastSearch;
  final List<CategoryDTO> categories;

  SearchSuggestDTO({
    required this.lastSearch,
    required this.categories,
  });

  @override
  List<Object> get props => [lastSearch, categories];

  static SearchSuggestDTO fromJson(dynamic json) {
    return json == null
      ? SearchSuggestDTO(lastSearch: [], categories: [])
      : SearchSuggestDTO(
        lastSearch: json['lastSearch'] == null
          ? [] 
          : List<String>.from(json['lastSearch']).toList(),
        categories: json['categories'] == null
          ? []
          : List<CategoryDTO>.from(json['categories']?.map(
              (v) => v == null ? null : CategoryDTO.fromJson(v))
            ).toList()
        );
  }
}
