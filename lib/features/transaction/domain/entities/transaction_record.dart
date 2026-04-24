class TransactionRecord {
  const TransactionRecord({
    required this.id,
    required this.bookId,
    required this.type,
    required this.status,
    required this.amount,
    required this.currencyCode,
    required this.occurredAt,
    this.accountId,
    this.categoryId,
    this.transferOutAccountId,
    this.transferInAccountId,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String bookId;
  final String type;
  final String status;
  final double amount;
  final String currencyCode;
  final DateTime occurredAt;
  final String? accountId;
  final String? categoryId;
  final String? transferOutAccountId;
  final String? transferInAccountId;
  final String? remark;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;

  TransactionRecord copyWith({
    String? id,
    String? bookId,
    String? type,
    String? status,
    double? amount,
    String? currencyCode,
    DateTime? occurredAt,
    String? accountId,
    String? categoryId,
    String? transferOutAccountId,
    String? transferInAccountId,
    String? remark,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return TransactionRecord(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      type: type ?? this.type,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      occurredAt: occurredAt ?? this.occurredAt,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      transferOutAccountId:
          transferOutAccountId ?? this.transferOutAccountId,
      transferInAccountId: transferInAccountId ?? this.transferInAccountId,
      remark: remark ?? this.remark,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}

