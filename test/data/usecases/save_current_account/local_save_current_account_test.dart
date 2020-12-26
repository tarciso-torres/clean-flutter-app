import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/helpers/domain_error.dart';
import 'package:ForDev/domain/entities/entities.dart';

import 'package:ForDev/data/cache/cache.dart';
import 'package:ForDev/data/usecases/save_current_account/save_current_account.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage{}

void main() {

  SaveSecureCacheStorageSpy saveSecuryCacheStorage;
  LocalSaveCurrentAccount sut;
  AccountEntity account;

  setUp(() {
    saveSecuryCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecuryCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  void mockError() {
    when(saveSecuryCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value')))
      .thenThrow(Exception());
  }

  test('Should call SaveSecureCacheStorage with correct values', () async {

    await sut.save(account);

    verify(saveSecuryCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}