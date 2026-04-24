import 'package:qbook/features/book/domain/entities/book.dart';
import 'package:qbook/features/book/domain/models/book_mutation.dart';

abstract class BookRepository {
  Stream<List<Book>> watchAll();

  Future<List<Book>> list();

  Future<Book?> findById(String id);

  Future<Book> create(CreateBookInput input);

  Future<Book> update(String id, UpdateBookInput input);

  Future<void> delete(String id);
}

