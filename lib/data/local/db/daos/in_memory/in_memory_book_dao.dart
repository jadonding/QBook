import 'dart:async';

import 'package:qbook/data/local/db/daos/book_dao.dart';
import 'package:qbook/features/book/domain/entities/book.dart';
import 'package:qbook/features/book/domain/models/book_mutation.dart';

class InMemoryBookDao extends BookDao {
  InMemoryBookDao();

  final Map<String, Book> _storage = <String, Book>{};
  final StreamController<List<Book>> _controller =
      StreamController<List<Book>>.broadcast();

  @override
  Future<Book> create(CreateBookInput input) async {
    final DateTime now = DateTime.now();
    final Book book = Book(
      id: input.id,
      ownerUserId: input.ownerUserId,
      name: input.name,
      currencyCode: input.currencyCode,
      isDefault: input.isDefault,
      isArchived: false,
      icon: input.icon,
      color: input.color,
      createdAt: now,
      updatedAt: now,
    );
    _storage[input.id] = book;
    _emit();
    return book;
  }

  @override
  Future<void> delete(String id) async {
    final Book? existing = _storage[id];
    if (existing == null) {
      return;
    }
    _storage[id] = existing.copyWith(
      isArchived: true,
      updatedAt: DateTime.now(),
    );
    _emit();
  }

  @override
  Future<Book?> findById(String id) async {
    return _storage[id];
  }

  @override
  Future<List<Book>> list() async {
    return _sortedBooks();
  }

  @override
  Future<void> softDelete(String id) {
    return delete(id);
  }

  @override
  Future<Book> update(String id, UpdateBookInput input) async {
    final Book? existing = _storage[id];
    if (existing == null) {
      throw StateError('Book not found: $id');
    }

    final Book updated = existing.copyWith(
      name: input.name ?? existing.name,
      currencyCode: input.currencyCode ?? existing.currencyCode,
      isDefault: input.isDefault ?? existing.isDefault,
      isArchived: input.isArchived ?? existing.isArchived,
      icon: input.icon ?? existing.icon,
      color: input.color ?? existing.color,
      updatedAt: DateTime.now(),
    );
    _storage[id] = updated;
    _emit();
    return updated;
  }

  @override
  Stream<List<Book>> watchAll() async* {
    yield _sortedBooks();
    yield* _controller.stream;
  }

  void _emit() {
    _controller.add(_sortedBooks());
  }

  List<Book> _sortedBooks() {
    final List<Book> books = _storage.values.toList()
      ..sort((Book a, Book b) => a.createdAt.compareTo(b.createdAt));
    return books;
  }
}

