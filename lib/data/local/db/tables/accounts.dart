import 'package:drift/drift.dart';

import 'package:qbook/data/local/db/tables/base_table.dart';

class Accounts extends Table with AuditColumns {
  TextColumn get bookId => text()();

  TextColumn get name => text()();

  TextColumn get type => text()();

  TextColumn get subtype => text().nullable()();

  TextColumn get currencyCode => text()();

  RealColumn get initialBalance => real().withDefault(const Constant(0))();

  RealColumn get currentBalance => real().withDefault(const Constant(0))();

  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  TextColumn get remark => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

