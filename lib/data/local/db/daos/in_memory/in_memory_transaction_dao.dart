import 'dart:async';

import 'package:qbook/data/local/db/daos/transaction_dao.dart';
import 'package:qbook/features/transaction/domain/entities/transaction_record.dart';
import 'package:qbook/features/transaction/domain/models/transaction_mutation.dart';

class InMemoryTransactionDao extends TransactionDao {
  InMemoryTransactionDao();

  final Map<String, TransactionRecord> _storage =
      <String, TransactionRecord>{};
  final StreamController<List<TransactionRecord>> _controller =
      StreamController<List<TransactionRecord>>.broadcast();

  @override
  Future<TransactionRecord> create(CreateTransactionInput input) async {
    final DateTime now = DateTime.now();
    final TransactionRecord record = TransactionRecord(
      id: input.id,
      bookId: input.bookId,
      type: input.type,
      status: 'posted',
      amount: input.amount,
      currencyCode: input.currencyCode,
      occurredAt: input.occurredAt,
      accountId: input.accountId,
      categoryId: input.categoryId,
      transferOutAccountId: input.transferOutAccountId,
      transferInAccountId: input.transferInAccountId,
      remark: input.remark,
      createdAt: now,
      updatedAt: now,
    );
    _storage[input.id] = record;
    _emit();
    return record;
  }

  @override
  Future<void> delete(String id) async {
    final TransactionRecord? existing = _storage[id];
    if (existing == null) {
      return;
    }
    _storage[id] = existing.copyWith(
      status: 'deleted',
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    );
    _emit();
  }

  @override
  Future<TransactionRecord?> findById(String id) async {
    return _storage[id];
  }

  @override
  Future<List<TransactionRecord>> list() async {
    return _sortedTransactions(_storage.values);
  }

  @override
  Future<List<TransactionRecord>> listByBook(String bookId) async {
    return _sortedTransactions(
      _storage.values.where((TransactionRecord item) => item.bookId == bookId),
    );
  }

  @override
  Future<void> softDelete(String id) {
    return delete(id);
  }

  @override
  Future<TransactionRecord> update(
    String id,
    UpdateTransactionInput input,
  ) async {
    final TransactionRecord? existing = _storage[id];
    if (existing == null) {
      throw StateError('Transaction not found: $id');
    }

    final TransactionRecord updated = existing.copyWith(
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
    _storage[id] = updated;
    _emit();
    return updated;
  }

  @override
  Stream<List<TransactionRecord>> watchByBook(String bookId) async* {
    yield await listByBook(bookId);
    yield* _controller.stream.map(
      (List<TransactionRecord> transactions) => _sortedTransactions(
        transactions.where((TransactionRecord item) => item.bookId == bookId),
      ),
    );
  }

  void _emit() {
    _controller.add(_storage.values.toList());
  }

  List<TransactionRecord> _sortedTransactions(
    Iterable<TransactionRecord> source,
  ) {
    final List<TransactionRecord> items = source.toList()
      ..sort((TransactionRecord a, TransactionRecord b) {
        final int occurredCompare = b.occurredAt.compareTo(a.occurredAt);
        if (occurredCompare != 0) {
          return occurredCompare;
        }
        return b.createdAt.compareTo(a.createdAt);
      });
    return items;
  }
}

