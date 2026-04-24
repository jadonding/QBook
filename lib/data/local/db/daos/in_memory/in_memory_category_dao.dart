import 'dart:async';

import 'package:qbook/data/local/db/daos/category_dao.dart';
import 'package:qbook/features/category/domain/entities/category.dart';
import 'package:qbook/features/category/domain/models/category_mutation.dart';

class InMemoryCategoryDao extends CategoryDao {
  InMemoryCategoryDao();

  final Map<String, Category> _storage = <String, Category>{};
  final StreamController<List<Category>> _controller =
      StreamController<List<Category>>.broadcast();

  @override
  Future<Category> create(CreateCategoryInput input) async {
    final DateTime now = DateTime.now();
    final Category category = Category(
      id: input.id,
      bookId: input.bookId,
      name: input.name,
      type: input.type,
      sortOrder: input.sortOrder,
      isSystem: input.isSystem,
      isEnabled: input.isEnabled,
      parentId: input.parentId,
      icon: input.icon,
      color: input.color,
      createdAt: now,
      updatedAt: now,
    );
    _storage[input.id] = category;
    _emit();
    return category;
  }

  @override
  Future<void> delete(String id) async {
    final Category? existing = _storage[id];
    if (existing == null) {
      return;
    }
    _storage[id] = existing.copyWith(
      isEnabled: false,
      updatedAt: DateTime.now(),
    );
    _emit();
  }

  @override
  Future<Category?> findById(String id) async {
    return _storage[id];
  }

  @override
  Future<List<Category>> list() async {
    return _sortedCategories(_storage.values);
  }

  @override
  Future<List<Category>> listByBook(String bookId) async {
    return _sortedCategories(
      _storage.values.where((Category category) => category.bookId == bookId),
    );
  }

  @override
  Future<void> softDelete(String id) {
    return delete(id);
  }

  @override
  Future<Category> update(String id, UpdateCategoryInput input) async {
    final Category? existing = _storage[id];
    if (existing == null) {
      throw StateError('Category not found: $id');
    }

    final Category updated = existing.copyWith(
      name: input.name ?? existing.name,
      type: input.type ?? existing.type,
      sortOrder: input.sortOrder ?? existing.sortOrder,
      parentId: input.parentId ?? existing.parentId,
      icon: input.icon ?? existing.icon,
      color: input.color ?? existing.color,
      isEnabled: input.isEnabled ?? existing.isEnabled,
      updatedAt: DateTime.now(),
    );
    _storage[id] = updated;
    _emit();
    return updated;
  }

  @override
  Stream<List<Category>> watchByBook(String bookId) async* {
    yield await listByBook(bookId);
    yield* _controller.stream.map(
      (List<Category> categories) => _sortedCategories(
        categories.where((Category category) => category.bookId == bookId),
      ),
    );
  }

  void _emit() {
    _controller.add(_storage.values.toList());
  }

  List<Category> _sortedCategories(Iterable<Category> source) {
    final List<Category> categories = source.toList()
      ..sort((Category a, Category b) {
        final int orderCompare = a.sortOrder.compareTo(b.sortOrder);
        if (orderCompare != 0) {
          return orderCompare;
        }
        return a.createdAt.compareTo(b.createdAt);
      });
    return categories;
  }
}

