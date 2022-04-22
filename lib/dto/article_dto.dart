import 'package:anylearn/dto/ask_dto.dart';

class ArticleDTO {
  final id;
  final title;
  final userName;
  final categoryName;
  final type;
  final image;
  final video;
  final shortContent;
  final content;
  final view;
  final createdAt;
  final related;

  ArticleDTO(
      {this.id,
      this.title,
      this.userName,
      this.categoryName,
      this.type,
      this.image,
      this.video,
      this.shortContent,
      this.content,
      this.view,
      this.createdAt,
      this.related});

  static ArticleDTO fromJson(dynamic json) {
    return json == ""
        ? ArticleDTO()
        : ArticleDTO(
            id: json['id'],
            title: json['title'],
            userName: json['user_name'],
            categoryName: json['category_name'],
            type: json['type'],
            image: json['image'],
            video: json['video'],
            shortContent: json['short_content'],
            content: json['content'],
            view: json['view'],
            createdAt: json['created_at'] == null ? null : DateTime.tryParse(json['created_at']),
            related: json['related'] == null
                ? null
                : List<ArticleDTO>.from(json['related']?.map((v) => v == null ? null : ArticleDTO.fromJson(v)))
                    .toList(),
          );
  }
}

class ArticlePagingDTO {
  final currentPage;
  final List<ArticleDTO> data;
  final from;
  final lastPage;
  final perPage;
  final to;
  final total;

  ArticlePagingDTO({this.currentPage, required this.data, this.from, this.lastPage, this.perPage, this.to, this.total});

  @override
  List<Object> get props => [currentPage, data, from, lastPage, perPage, to, total];

  @override
  String toString() {
    return 'PagingDTO {currentPage: $currentPage, total: $total, perPage: $perPage}';
  }

  static ArticlePagingDTO fromJson(dynamic json) {
    return json == ""
        ? ArticlePagingDTO(data: [])
        : ArticlePagingDTO(
            currentPage: json['current_page'],
            data: List<ArticleDTO>.from(json['data']?.map((v) => v == null ? null : ArticleDTO.fromJson(v))).toList(),
            from: json['from'],
            to: json['to'],
            perPage: json['per_page'],
            lastPage: json['last_page'],
            total: json['total'],
          );
  }
}

class ArticleHomeDTO {
  final List<ArticleDTO> reads;
  final List<ArticleDTO> videos;
  final List<AskDTO> asks;

  ArticleHomeDTO({required this.reads, required this.videos,required  this.asks});

  static ArticleHomeDTO fromJson(dynamic json) {
    return json == ""
        ? ArticleHomeDTO(reads: [], videos: [], asks: [])
        : ArticleHomeDTO(
            reads: List<ArticleDTO>.from(
                    json['reads']?.map(
                      (e) => e == null ? null : ArticleDTO.fromJson(e),
                    ),
                  ),
            videos: List<ArticleDTO>.from(
                    json['videos']?.map(
                      (e) => e == null ? null : ArticleDTO.fromJson(e),
                    ),
                  ),
            asks:  List<AskDTO>.from(
                    json['asks']?.map(
                      (e) => e == null ? null : AskDTO.fromJson(e),
                    ),
                  ),
          );
  }
}
