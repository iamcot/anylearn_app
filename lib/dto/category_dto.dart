class CategoryDTO {
  final id;
  final title;

  CategoryDTO({
    this.id,
    this.title,
  });

  static CategoryDTO fromJson(dynamic json) {
    return json == ""
        ? CategoryDTO()
        : CategoryDTO(
            id: json['id'],
            title: json['title'],
          );
  }
}
