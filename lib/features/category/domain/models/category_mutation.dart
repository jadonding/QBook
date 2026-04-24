class CreateCategoryInput {
  const CreateCategoryInput({
    required this.id,
    required this.bookId,
    required this.name,
    required this.type,
    this.sortOrder = 0,
    this.parentId,
    this.icon,
    this.color,
    this.isSystem = false,
    this.isEnabled = true,
  });

  final String id;
  final String bookId;
  final String name;
  final String type;
  final int sortOrder;
  final String? parentId;
  final String? icon;
  final String? color;
  final bool isSystem;
  final bool isEnabled;
}

class UpdateCategoryInput {
  const UpdateCategoryInput({
    this.name,
    this.type,
    this.sortOrder,
    this.parentId,
    this.icon,
    this.color,
    this.isEnabled,
  });

  final String? name;
  final String? type;
  final int? sortOrder;
  final String? parentId;
  final String? icon;
  final String? color;
  final bool? isEnabled;
}

