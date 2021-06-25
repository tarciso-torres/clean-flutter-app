import 'package:faker/faker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/infra/cache/cache.dart';

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  String key;
  dynamic value;
  LocalStorageSpy localStorage;
  LocalStorageAdapter sut;

  void mockDeleteCacheError() =>
      when(localStorage.deleteItem(any)).thenThrow(Exception());

  void mockSetItemError() =>
      when(localStorage.setItem(any, any)).thenThrow(Exception());

  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    localStorage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  group('save', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.save(key: key, value: value);

      verify(localStorage.deleteItem(key)).called(1);
      verify(localStorage.setItem(key, value)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      mockDeleteCacheError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });

    test('Should throw if setItem throws', () async {
      mockSetItemError();

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.delete(key);

      verify(localStorage.deleteItem(key)).called(1);
    });

    test('Should throw if deleteItem throws', () async {
      mockDeleteCacheError();

      final future = sut.delete(key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('fetch', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.fetch(key);

      verify(localStorage.deleteItem(key)).called(1);
    });

  });
}
