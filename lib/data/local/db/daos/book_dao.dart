import 'package:qbook/data/local/db/daos/base_dao.dart';
import 'package:qbook/features/book/domain/entities/book.dart';
import 'package:qbook/features/book/domain/models/book_mutation.dart';

abstract class BookDao extends BaseDao<Book> {
  const BookDao();

  Stream<List<Book>> watchAll();

  Future<Book> create(CreateBookInput input);

  Future<Book> update(String id, UpdateBookInput input);
}

