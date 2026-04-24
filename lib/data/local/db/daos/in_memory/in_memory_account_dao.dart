import 'dart:async';

import 'package:qbook/data/local/db/daos/account_dao.dart';
import 'package:qbook/features/account/domain/entities/account.dart';
import 'package:qbook/features/account/domain/models/account_mutation.dart';

class InMemoryAccountDao extends AccountDao {
  InMemoryAccountDao();

  final Map<String, Account> _storage = <String, Account>{};
  final StreamController<List<Account>> _controller =
      StreamController<List<Account>>.broadcast();

  @override
  Future<Account> create(CreateAccountInput input) async {
    final DateTime now = DateTime.now();
    final Account account = Account(
      id: input.id,
      bookId: input.bookId,
      name: input.name,
      type: input.type,
      currencyCode: input.currencyCode,
      initialBalance: input.initialBalance,
      currentBalance: input.initialBalance,
      isHidden: false,
      isArchived: false,
      subtype: input.subtype,
      remark: input.remark,
      createdAt: now,
      updatedAt: now,
    );
    _storage[input.id] = account;
    _emit();
    return account;
  }

  @override
  Future<void> delete(String id) async {
    final Account? existing = _storage[id];
    if (existing == null) {
      return;
    }
    _storage[id] = existing.copyWith(
      isArchived: true,
      updatedAt: DateTime.now(),
    );
    _emit();
  }

  @override
  Future<Account?> findById(String id) async {
    return _storage[id];
  }

  @override
  Future<List<Account>> list() async {
    return _sortedAccounts(_storage.values);
  }

  @override
  Future<List<Account>> listByBook(String bookId) async {
    return _sortedAccounts(
      _storage.values.where((Account account) => account.bookId == bookId),
    );
  }

  @override
  Future<void> softDelete(String id) {
    return delete(id);
  }

  @override
  Future<Account> update(String id, UpdateAccountInput input) async {
    final Account? existing = _storage[id];
    if (existing == null) {
      throw StateError('Account not found: $id');
    }

    final Account updated = existing.copyWith(
      name: input.name ?? existing.name,
      type: input.type ?? existing.type,
      currencyCode: input.currencyCode ?? existing.currencyCode,
      currentBalance: input.currentBalance ?? existing.currentBalance,
      isHidden: input.isHidden ?? existing.isHidden,
      isArchived: input.isArchived ?? existing.isArchived,
      subtype: input.subtype ?? existing.subtype,
      remark: input.remark ?? existing.remark,
      updatedAt: DateTime.now(),
    );
    _storage[id] = updated;
    _emit();
    return updated;
  }

  @override
  Stream<List<Account>> watchByBook(String bookId) async* {
    yield await listByBook(bookId);
    yield* _controller.stream.map(
      (List<Account> accounts) => _sortedAccounts(
        accounts.where((Account account) => account.bookId == bookId),
      ),
    );
  }

  void _emit() {
    _controller.add(_storage.values.toList());
  }

  List<Account> _sortedAccounts(Iterable<Account> source) {
    final List<Account> accounts = source.toList()
      ..sort((Account a, Account b) => a.createdAt.compareTo(b.createdAt));
    return accounts;
  }
}

