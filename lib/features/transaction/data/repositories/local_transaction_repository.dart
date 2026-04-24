import 'package:qbook/data/local/db/daos/transaction_dao.dart';
import 'package:qbook/features/transaction/domain/entities/transaction_record.dart';
import 'package:qbook/features/transaction/domain/models/transaction_mutation.dart';
import 'package:qbook/features/transaction/domain/repositories/transaction_repository.dart';

class LocalTransactionRepository implements TransactionRepository {
  const LocalTransactionRepository(this._transactionDao);

  final TransactionDao _transactionDao;

  @override
  Future<TransactionRecord> create(CreateTransactionInput input) {
    return _transactionDao.create(input);
  }

  @override
  Future<void> delete(String id) {
    return _transactionDao.delete(id);
  }

  @override
  Future<TransactionRecord?> findById(String id) {
    return _transactionDao.findById(id);
  }

  @override
  Future<List<TransactionRecord>> listByBook(String bookId) {
    return _transactionDao.listByBook(bookId);
  }

  @override
  Future<TransactionRecord> update(String id, UpdateTransactionInput input) {
    return _transactionDao.update(id, input);
  }

  @override
  Stream<List<TransactionRecord>> watchByBook(String bookId) {
    return _transactionDao.watchByBook(bookId);
  }
}

