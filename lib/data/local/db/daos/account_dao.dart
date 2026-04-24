import 'package:qbook/data/local/db/daos/base_dao.dart';
import 'package:qbook/features/account/domain/entities/account.dart';
import 'package:qbook/features/account/domain/models/account_mutation.dart';

abstract class AccountDao extends BaseDao<Account> {
  const AccountDao();

  Stream<List<Account>> watchByBook(String bookId);

  Future<List<Account>> listByBook(String bookId);

  Future<Account> create(CreateAccountInput input);

  Future<Account> update(String id, UpdateAccountInput input);
}

