class Business {
  final String name;
  final String? businessId;
  final String description;
  final String owner;
  final String? imageUrl;

  const Business({
    required this.name,
    this.businessId,
    required this.description,
    required this.owner,
    this.imageUrl
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['businessName'],
      businessId: json['businessId'],
      description: json['businessDescription'],
      owner: json['businessOwnerId'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'Business{name: $name, businessId: $businessId, description: $description, owner: $owner, imageUrl: $imageUrl}';
  }
}
