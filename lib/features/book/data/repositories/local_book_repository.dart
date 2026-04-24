import 'package:qbook/data/local/db/daos/book_dao.dart';
import 'package:qbook/features/book/domain/entities/book.dart';
import 'package:qbook/features/book/domain/models/book_mutation.dart';
import 'package:qbook/features/book/domain/repositories/book_repository.dart';

class LocalBookRepository implements BookRepository {
  const LocalBookRepository(this._bookDao);

  final BookDao _bookDao;

  @override
  Future<Book> create(CreateBookInput input) {
    return _bookDao.create(input);
  }

  @override
  Future<void> delete(String id) {
    return _bookDao.delete(id);
  }

  @override
  Future<Book?> findById(String id) {
    return _bookDao.findById(id);
  }

  @override
  Future<List<Book>> list() {
    return _bookDao.list();
  }

  @override
  Future<Book> update(String id, UpdateBookInput input) {
    return _bookDao.update(id, input);
  }

  @override
  Stream<List<Book>> watchAll() {
    return _bookDao.watchAll();
  }
}

