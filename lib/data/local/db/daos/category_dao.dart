import 'package:qbook/data/local/db/daos/base_dao.dart';
import 'package:qbook/features/category/domain/entities/category.dart';
import 'package:qbook/features/category/domain/models/category_mutation.dart';

abstract class CategoryDao extends BaseDao<Category> {
  const CategoryDao();

  Stream<List<Category>> watchByBook(String bookId);

  Future<List<Category>> listByBook(String bookId);

  Future<Category> create(CreateCategoryInput input);

  Future<Category> update(String id, UpdateCategoryInput input);
}

