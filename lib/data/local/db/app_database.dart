import 'package:qbook/data/local/db/daos/account_dao.dart';
import 'package:qbook/data/local/db/daos/base_dao.dart';
import 'package:qbook/data/local/db/daos/book_dao.dart';
import 'package:qbook/data/local/db/daos/category_dao.dart';
import 'package:qbook/data/local/db/daos/transaction_dao.dart';
import 'package:qbook/data/local/db/migration/app_migrator.dart';

class AppDatabaseModule {
  AppDatabaseModule({
    required this.migrator,
    required this.bookDao,
    required this.accountDao,
    required this.categoryDao,
    required this.transactionDao,
  });

  final AppMigrator migrator;
  final BookDao bookDao;
  final AccountDao accountDao;
  final CategoryDao categoryDao;
  final TransactionDao transactionDao;

  static const int schemaVersion = 1;

  Iterable<BaseDao<dynamic>> registerDaos() {
    return <BaseDao<dynamic>>[
      bookDao,
      accountDao,
      categoryDao,
      transactionDao,
    ];
  }
}
