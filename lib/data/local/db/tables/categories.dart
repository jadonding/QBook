import 'package:drift/drift.dart';

import 'package:qbook/data/local/db/tables/base_table.dart';

class Categories extends Table with AuditColumns {
  TextColumn get bookId => text()();

  TextColumn get parentId => text().nullable()();

  TextColumn get name => text()();

  TextColumn get type => text()();

  TextColumn get icon => text().nullable()();

  TextColumn get color => text().nullable()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

