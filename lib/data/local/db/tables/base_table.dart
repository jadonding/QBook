import 'package:drift/drift.dart';

mixin AuditColumns on Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();
}

