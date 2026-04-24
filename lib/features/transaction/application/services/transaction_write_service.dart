import 'package:qbook/features/account/domain/entities/account.dart';
import 'package:qbook/features/account/domain/models/account_mutation.dart';
import 'package:qbook/features/account/domain/repositories/account_repository.dart';
import 'package:qbook/features/transaction/domain/entities/transaction_record.dart';
import 'package:qbook/features/transaction/domain/models/transaction_mutation.dart';
import 'package:qbook/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionWriteService {
  const TransactionWriteService({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
  })  : _transactionRepository = transactionRepository,
        _accountRepository = accountRepository;

  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  Future<TransactionRecord> create(CreateTransactionInput input) async {
    _validateInput(input);
    final TransactionRecord record = await _transactionRepository.create(input);
    try {
      await _applyDelta(record, reverse: false);
      return record;
    } catch (_) {
      await _transactionRepository.delete(record.id);
      rethrow;
    }
  }

  Future<TransactionRecord> update(
    String id,
    UpdateTransactionInput input,
  ) async {
    final TransactionRecord? existing =
        await _transactionRepository.findById(id);
    if (existing == null) {
      throw StateError('Transaction not found: $id');
    }

    final TransactionRecord preview = _previewUpdatedRecord(existing, input);
    _validateRecord(preview);

    await _applyDelta(existing, reverse: true);
    try {
      final TransactionRecord updated = await _transactionRepository.update(
        id,
        input,
      );
      await _applyDelta(updated, reverse: false);
      return updated;
    } catch (_) {
      await _applyDelta(existing, reverse: false);
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    final TransactionRecord? existing =
        await _transactionRepository.findById(id);
    if (existing == null || existing.isDeleted) {
      return;
    }

    await _applyDelta(existing, reverse: true);
    await _transactionRepository.delete(id);
  }

  TransactionRecord _previewUpdatedRecord(
    TransactionRecord existing,
    UpdateTransactionInput input,
  ) {
    return existing.copyWith(
      type: input.type ?? existing.type,
      status: input.status ?? existing.status,
      amount: input.amount ?? existing.amount,
      currencyCode: input.currencyCode ?? existing.currencyCode,
      occurredAt: input.occurredAt ?? existing.occurredAt,
      accountId: input.accountId ?? existing.accountId,
      categoryId: input.categoryId ?? existing.categoryId,
      transferOutAccountId:
          input.transferOutAccountId ?? existing.transferOutAccountId,
      transferInAccountId:
          input.transferInAccountId ?? existing.transferInAccountId,
      remark: input.remark ?? existing.remark,
      updatedAt: DateTime.now(),
    );
  }

  void _validateInput(CreateTransactionInput input) {
    _validateType(input.type);
    if (input.amount <= 0) {
      throw ArgumentError.value(
        input.amount,
        'amount',
        'must be greater than 0',
      );
    }

    switch (input.type) {
      case 'expense':
      case 'income':
        if (input.accountId == null) {
          throw ArgumentError('accountId is required for ${input.type}');
        }
        break;
      case 'transfer':
        if (input.transferOutAccountId == null ||
            input.transferInAccountId == null) {
          throw ArgumentError(
            'transferOutAccountId and transferInAccountId are required',
          );
        }
        if (input.transferOutAccountId == input.transferInAccountId) {
          throw ArgumentError('transfer accounts must be different');
        }
        break;
    }
  }

  void _validateRecord(TransactionRecord record) {
    _validateType(record.type);
    if (record.amount <= 0) {
      throw StateError('Transaction amount must be greater than 0');
    }
    _validateRecordShape(record);
  }

  void _validateType(String type) {
    if (type != 'expense' && type != 'income' && type != 'transfer') {
      throw ArgumentError.value(type, 'type', 'unsupported transaction type');
    }
  }

  void _validateRecordShape(TransactionRecord record) {
    switch (record.type) {
      case 'expense':
      case 'income':
        if (record.accountId == null) {
          throw StateError('accountId is required for ${record.type}');
        }
        break;
      case 'transfer':
        if (record.transferOutAccountId == null ||
            record.transferInAccountId == null) {
          throw StateError(
            'transferOutAccountId and transferInAccountId are required',
          );
        }
        if (record.transferOutAccountId == record.transferInAccountId) {
          throw StateError('transfer accounts must be different');
        }
        break;
    }
  }

  Future<void> _applyDelta(
    TransactionRecord record, {
    required bool reverse,
  }) async {
    final double amount = reverse ? -record.amount : record.amount;

    switch (record.type) {
      case 'expense':
        await _applyBalanceChange(record.accountId, -amount);
        break;
      case 'income':
        await _applyBalanceChange(record.accountId, amount);
        break;
      case 'transfer':
        await _applyBalanceChange(record.transferOutAccountId, -amount);
        await _applyBalanceChange(record.transferInAccountId, amount);
        break;
    }
  }

  Future<void> _applyBalanceChange(String? accountId, double delta) async {
    if (accountId == null) {
      throw StateError('Account id is required for balance update');
    }

    final Account? account = await _accountRepository.findById(accountId);
    if (account == null) {
      throw StateError('Account not found: $accountId');
    }

    await _accountRepository.update(
      accountId,
      UpdateAccountInput(
        currentBalance: account.currentBalance + delta,
      ),
    );
  }
}
