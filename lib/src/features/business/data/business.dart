class Business {
  final String name;
  final String? businessId;
  final String description;
  final String owner;

  const Business({
    required this.name,
    this.businessId,
    required this.description,
    required this.owner,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['Name'],
      businessId: json['BusinessId'],
      description: json['Description'],
      owner: json['Owner'],
    );
  }

  @override
  String toString() {
    return 'Business{name: $name, businessId: $businessId, description: $description, owner: $owner}';
  }
}
