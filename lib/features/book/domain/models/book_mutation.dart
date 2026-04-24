class CreateBookInput {
  const CreateBookInput({
    required this.id,
    required this.ownerUserId,
    required this.name,
    required this.currencyCode,
    this.isDefault = false,
    this.icon,
    this.color,
  });

  final String id;
  final String ownerUserId;
  final String name;
  final String currencyCode;
  final bool isDefault;
  final String? icon;
  final String? color;
}

class UpdateBookInput {
  const UpdateBookInput({
    this.name,
    this.currencyCode,
    this.isDefault,
    this.isArchived,
    this.icon,
    this.color,
  });

  final String? name;
  final String? currencyCode;
  final bool? isDefault;
  final bool? isArchived;
  final String? icon;
  final String? color;
}

