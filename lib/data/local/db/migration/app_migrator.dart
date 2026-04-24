class AppMigrator {
  const AppMigrator({
    this.currentSchemaVersion = 1,
  });

  final int currentSchemaVersion;

  Future<void> migrate({
    required int from,
    required int to,
  }) async {
    if (from == to) {
      return;
    }

    if (to > currentSchemaVersion) {
      throw StateError(
        'Target schema version $to is higher than supported '
        'version $currentSchemaVersion.',
      );
    }
  }
}

