import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/data/cache/cache.dart';

class AutorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AutorizeHttpClientDecorator({ @required this.fetchSecureCacheStorage });

  Future<void> request() async {
    fetchSecureCacheStorage.fetchSecure('token');
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  AutorizeHttpClientDecorator sut;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AutorizeHttpClientDecorator(fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {

    await sut.request();

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  
  });
}
    
    