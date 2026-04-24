import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qbook/data/local/db/daos/account_dao.dart';
import 'package:qbook/data/local/db/daos/in_memory/in_memory_account_dao.dart';
import 'package:qbook/features/account/data/repositories/local_account_repository.dart';
import 'package:qbook/features/account/domain/repositories/account_repository.dart';

final Provider<AccountDao> accountDaoProvider = Provider<AccountDao>(
  (Ref ref) => InMemoryAccountDao(),
);

final Provider<AccountRepository> accountRepositoryProvider =
    Provider<AccountRepository>(
  (Ref ref) => LocalAccountRepository(ref.watch(accountDaoProvider)),
);

