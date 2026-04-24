class Book {
  const Book({
    required this.id,
    required this.ownerUserId,
    required this.name,
    required this.currencyCode,
    required this.isDefault,
    required this.isArchived,
    this.icon,
    this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String ownerUserId;
  final String name;
  final String currencyCode;
  final bool isDefault;
  final bool isArchived;
  final String? icon;
  final String? color;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book copyWith({
    String? id,
    String? ownerUserId,
    String? name,
    String? currencyCode,
    bool? isDefault,
    bool? isArchived,
    String? icon,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Book(
      id: id ?? this.id,
      ownerUserId: ownerUserId ?? this.ownerUserId,
      name: name ?? this.name,
      currencyCode: currencyCode ?? this.currencyCode,
      isDefault: isDefault ?? this.isDefault,
      isArchived: isArchived ?? this.isArchived,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
