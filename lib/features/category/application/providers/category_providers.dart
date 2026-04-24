import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qbook/data/local/db/daos/category_dao.dart';
import 'package:qbook/data/local/db/daos/in_memory/in_memory_category_dao.dart';
import 'package:qbook/features/category/data/repositories/local_category_repository.dart';
import 'package:qbook/features/category/domain/repositories/category_repository.dart';

final Provider<CategoryDao> categoryDaoProvider = Provider<CategoryDao>(
  (Ref ref) => InMemoryCategoryDao(),
);

final Provider<CategoryRepository> categoryRepositoryProvider =
    Provider<CategoryRepository>(
  (Ref ref) => LocalCategoryRepository(ref.watch(categoryDaoProvider)),
);

