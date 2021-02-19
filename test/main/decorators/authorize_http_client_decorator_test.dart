import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/data/cache/cache.dart';

class AutorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AutorizeHttpClientDecorator({ @required this.fetchSecureCacheStorage });

  Future<void> request({
    @required String url,
    @required String method,
    Map body,
    Map headers
  }) async {
    fetchSecureCacheStorage.fetchSecure('token');
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  AutorizeHttpClientDecorator sut;
  String url;
  String method;
  Map body;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AutorizeHttpClientDecorator(fetchSecureCacheStorage: fetchSecureCacheStorage);
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {

    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  
  });
}
    
    