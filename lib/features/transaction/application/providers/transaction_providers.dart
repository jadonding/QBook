import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qbook/data/local/db/daos/in_memory/in_memory_transaction_dao.dart';
import 'package:qbook/data/local/db/daos/transaction_dao.dart';
import 'package:qbook/features/transaction/application/services/transaction_write_service.dart';
import 'package:qbook/features/transaction/data/repositories/local_transaction_repository.dart';
import 'package:qbook/features/transaction/domain/repositories/transaction_repository.dart';

import 'package:qbook/features/account/application/providers/account_providers.dart';

final Provider<TransactionDao> transactionDaoProvider =
    Provider<TransactionDao>(
  (Ref ref) => InMemoryTransactionDao(),
);

final Provider<TransactionRepository> transactionRepositoryProvider =
    Provider<TransactionRepository>(
  (Ref ref) => LocalTransactionRepository(ref.watch(transactionDaoProvider)),
);

final Provider<TransactionWriteService> transactionWriteServiceProvider =
    Provider<TransactionWriteService>(
  (Ref ref) => TransactionWriteService(
    transactionRepository: ref.watch(transactionRepositoryProvider),
    accountRepository: ref.watch(accountRepositoryProvider),
  ),
);

