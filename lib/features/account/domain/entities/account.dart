class Account {
  const Account({
    required this.id,
    required this.bookId,
    required this.name,
    required this.type,
    required this.currencyCode,
    required this.initialBalance,
    required this.currentBalance,
    required this.isHidden,
    required this.isArchived,
    this.subtype,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String bookId;
  final String name;
  final String type;
  final String currencyCode;
  final double initialBalance;
  final double currentBalance;
  final bool isHidden;
  final bool isArchived;
  final String? subtype;
  final String? remark;
  final DateTime createdAt;
  final DateTime updatedAt;

  Account copyWith({
    String? id,
    String? bookId,
    String? name,
    String? type,
    String? currencyCode,
    double? initialBalance,
    double? currentBalance,
    bool? isHidden,
    bool? isArchived,
    String? subtype,
    String? remark,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      name: name ?? this.name,
      type: type ?? this.type,
      currencyCode: currencyCode ?? this.currencyCode,
      initialBalance: initialBalance ?? this.initialBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      isHidden: isHidden ?? this.isHidden,
      isArchived: isArchived ?? this.isArchived,
      subtype: subtype ?? this.subtype,
      remark: remark ?? this.remark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
