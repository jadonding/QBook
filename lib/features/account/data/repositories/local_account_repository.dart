import 'package:qbook/data/local/db/daos/account_dao.dart';
import 'package:qbook/features/account/domain/entities/account.dart';
import 'package:qbook/features/account/domain/models/account_mutation.dart';
import 'package:qbook/features/account/domain/repositories/account_repository.dart';

class LocalAccountRepository implements AccountRepository {
  const LocalAccountRepository(this._accountDao);

  final AccountDao _accountDao;

  @override
  Future<Account> create(CreateAccountInput input) {
    return _accountDao.create(input);
  }

  @override
  Future<void> delete(String id) {
    return _accountDao.delete(id);
  }

  @override
  Future<Account?> findById(String id) {
    return _accountDao.findById(id);
  }

  @override
  Future<List<Account>> listByBook(String bookId) {
    return _accountDao.listByBook(bookId);
  }

  @override
  Future<Account> update(String id, UpdateAccountInput input) {
    return _accountDao.update(id, input);
  }

  @override
  Stream<List<Account>> watchByBook(String bookId) {
    return _accountDao.watchByBook(bookId);
  }
}

