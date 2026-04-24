import 'package:drift/drift.dart';

import 'package:qbook/data/local/db/tables/base_table.dart';

class Books extends Table with AuditColumns {
  TextColumn get ownerUserId => text()();

  TextColumn get name => text()();

  TextColumn get icon => text().nullable()();

  TextColumn get color => text().nullable()();

  TextColumn get currencyCode => text()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

