class CreateTransactionInput {
  const CreateTransactionInput({
    required this.id,
    required this.bookId,
    required this.type,
    required this.amount,
    required this.currencyCode,
    required this.occurredAt,
    this.accountId,
    this.categoryId,
    this.transferOutAccountId,
    this.transferInAccountId,
    this.remark,
  });

  final String id;
  final String bookId;
  final String type;
  final double amount;
  final String currencyCode;
  final DateTime occurredAt;
  final String? accountId;
  final String? categoryId;
  final String? transferOutAccountId;
  final String? transferInAccountId;
  final String? remark;
}

class UpdateTransactionInput {
  const UpdateTransactionInput({
    this.type,
    this.amount,
    this.currencyCode,
    this.occurredAt,
    this.accountId,
    this.categoryId,
    this.transferOutAccountId,
    this.transferInAccountId,
    this.remark,
    this.status,
  });

  final String? type;
  final double? amount;
  final String? currencyCode;
  final DateTime? occurredAt;
  final String? accountId;
  final String? categoryId;
  final String? transferOutAccountId;
  final String? transferInAccountId;
  final String? remark;
  final String? status;
}

