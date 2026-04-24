import 'package:qbook/features/transaction/domain/entities/transaction_record.dart';
import 'package:qbook/features/transaction/domain/models/transaction_mutation.dart';

abstract class TransactionRepository {
  Stream<List<TransactionRecord>> watchByBook(String bookId);

  Future<List<TransactionRecord>> listByBook(String bookId);

  Future<TransactionRecord?> findById(String id);

  Future<TransactionRecord> create(CreateTransactionInput input);

  Future<TransactionRecord> update(String id, UpdateTransactionInput input);

  Future<void> delete(String id);
}

