import 'package:qbook/features/account/domain/entities/account.dart';
import 'package:qbook/features/account/domain/models/account_mutation.dart';

abstract class AccountRepository {
  Stream<List<Account>> watchByBook(String bookId);

  Future<List<Account>> listByBook(String bookId);

  Future<Account?> findById(String id);

  Future<Account> create(CreateAccountInput input);

  Future<Account> update(String id, UpdateAccountInput input);

  Future<void> delete(String id);
}

