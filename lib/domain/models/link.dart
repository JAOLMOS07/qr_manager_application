class Link {
  String? contentId;
  String? contentTitle;
  String? contentLogoUrl;
  String lastRenewalDate;
  int subscriptionType;
  bool active;
  String id;
  DateTime? deletedOn;
  DateTime createdOn;
  DateTime lastModifiedOn;

  Link({
    this.contentId,
    this.contentTitle,
    this.contentLogoUrl,
    required this.lastRenewalDate,
    required this.subscriptionType,
    required this.active,
    required this.id,
    this.deletedOn,
    required this.createdOn,
    required this.lastModifiedOn,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      contentId: json['contentId'],
      contentTitle: json['contentTitle'],
      contentLogoUrl: json['contentLogoUrl'],
      lastRenewalDate: json['lastRenewalDate'],
      subscriptionType: json['subscriptionType'],
      active: json['active'],
      id: json['id'],
      deletedOn:
          json['deletedOn'] != null ? DateTime.parse(json['deletedOn']) : null,
      createdOn: DateTime.parse(json['createdOn']),
      lastModifiedOn: DateTime.parse(json['lastModifiedOn']),
    );
  }
}
