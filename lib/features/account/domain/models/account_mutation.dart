class CreateAccountInput {
  const CreateAccountInput({
    required this.id,
    required this.bookId,
    required this.name,
    required this.type,
    required this.currencyCode,
    this.initialBalance = 0,
    this.subtype,
    this.remark,
  });

  final String id;
  final String bookId;
  final String name;
  final String type;
  final String currencyCode;
  final double initialBalance;
  final String? subtype;
  final String? remark;
}

class UpdateAccountInput {
  const UpdateAccountInput({
    this.name,
    this.type,
    this.currencyCode,
    this.currentBalance,
    this.isHidden,
    this.isArchived,
    this.subtype,
    this.remark,
  });

  final String? name;
  final String? type;
  final String? currencyCode;
  final double? currentBalance;
  final bool? isHidden;
  final bool? isArchived;
  final String? subtype;
  final String? remark;
}

