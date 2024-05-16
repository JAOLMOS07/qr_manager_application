class Link {
  final String? contentId;
  final String? contentTitle;
  final String lastRenewalDate;
  final int subscriptionType;
  final bool active;
  final String id;
  final DateTime? deletedOn;
  final DateTime createdOn;
  final DateTime lastModifiedOn;

  Link({
    this.contentId,
    this.contentTitle,
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