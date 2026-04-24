import 'package:qbook/data/local/db/daos/category_dao.dart';
import 'package:qbook/features/category/domain/entities/category.dart';
import 'package:qbook/features/category/domain/models/category_mutation.dart';
import 'package:qbook/features/category/domain/repositories/category_repository.dart';

class LocalCategoryRepository implements CategoryRepository {
  const LocalCategoryRepository(this._categoryDao);

  final CategoryDao _categoryDao;

  @override
  Future<Category> create(CreateCategoryInput input) {
    return _categoryDao.create(input);
  }

  @override
  Future<void> delete(String id) {
    return _categoryDao.delete(id);
  }

  @override
  Future<Category?> findById(String id) {
    return _categoryDao.findById(id);
  }

  @override
  Future<List<Category>> listByBook(String bookId) {
    return _categoryDao.listByBook(bookId);
  }

  @override
  Future<Category> update(String id, UpdateCategoryInput input) {
    return _categoryDao.update(id, input);
  }

  @override
  Stream<List<Category>> watchByBook(String bookId) {
    return _categoryDao.watchByBook(bookId);
  }
}

