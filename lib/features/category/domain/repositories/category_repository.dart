import 'package:qbook/features/category/domain/entities/category.dart';
import 'package:qbook/features/category/domain/models/category_mutation.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchByBook(String bookId);

  Future<List<Category>> listByBook(String bookId);

  Future<Category?> findById(String id);

  Future<Category> create(CreateCategoryInput input);

  Future<Category> update(String id, UpdateCategoryInput input);

  Future<void> delete(String id);
}

