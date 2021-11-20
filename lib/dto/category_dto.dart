class CategoryDTO {
  final int id;
  final String title;

  CategoryDTO({
    this.id,
    this.title,
  });

  static CategoryDTO fromJson(dynamic json) {
    return json == null
        ? null
        : CategoryDTO(
            id: json['id'],
            title: json['title'],
          );
  }
}
