class Category {
  const Category({
    required this.id,
    required this.bookId,
    required this.name,
    required this.type,
    required this.sortOrder,
    required this.isSystem,
    required this.isEnabled,
    this.parentId,
    this.icon,
    this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String bookId;
  final String name;
  final String type;
  final int sortOrder;
  final bool isSystem;
  final bool isEnabled;
  final String? parentId;
  final String? icon;
  final String? color;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category copyWith({
    String? id,
    String? bookId,
    String? name,
    String? type,
    int? sortOrder,
    bool? isSystem,
    bool? isEnabled,
    String? parentId,
    String? icon,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      name: name ?? this.name,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem ?? this.isSystem,
      isEnabled: isEnabled ?? this.isEnabled,
      parentId: parentId ?? this.parentId,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
