import 'package:qbook/data/local/db/daos/base_dao.dart';
import 'package:qbook/features/transaction/domain/entities/transaction_record.dart';
import 'package:qbook/features/transaction/domain/models/transaction_mutation.dart';

abstract class TransactionDao extends BaseDao<TransactionRecord> {
  const TransactionDao();

  Stream<List<TransactionRecord>> watchByBook(String bookId);

  Future<List<TransactionRecord>> listByBook(String bookId);

  Future<TransactionRecord> create(CreateTransactionInput input);

  Future<TransactionRecord> update(String id, UpdateTransactionInput input);
}

