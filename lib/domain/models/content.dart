class Content {
  final String id;
  final String title;
  final String description;
  final String logoUrl;
  final List<String> multimedia;
  final String createdOn;
  final String lastModifiedOn;
  final String? deletedOn;

  Content({
    required this.id,
    required this.title,
    required this.description,
    required this.logoUrl,
    required this.multimedia,
    required this.createdOn,
    required this.lastModifiedOn,
    this.deletedOn,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      multimedia: (json['multimedia'] as List<dynamic>)
          .map((item) => item.toString())
          .toList(),
      createdOn: json['createdOn'] ?? '',
      lastModifiedOn: json['lastModifiedOn'] ?? '',
      deletedOn: json['deletedOn'] != null ? json['deletedOn'] ?? '' : null,
    );
  }
}
