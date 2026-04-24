import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qbook/data/local/db/daos/book_dao.dart';
import 'package:qbook/data/local/db/daos/in_memory/in_memory_book_dao.dart';
import 'package:qbook/features/book/data/repositories/local_book_repository.dart';
import 'package:qbook/features/book/domain/repositories/book_repository.dart';

final Provider<BookDao> bookDaoProvider = Provider<BookDao>(
  (Ref ref) => InMemoryBookDao(),
);

final Provider<BookRepository> bookRepositoryProvider =
    Provider<BookRepository>(
  (Ref ref) => LocalBookRepository(ref.watch(bookDaoProvider)),
);

