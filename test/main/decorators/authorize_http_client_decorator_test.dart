import 'package:ForDev/data/http/http.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/data/cache/cache.dart';

import '../../data/usecases/add_account/remote_add_account_test.dart';

class AutorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AutorizeHttpClientDecorator({ 
    @required this.fetchSecureCacheStorage,
    @required this.decoratee });

  Future<void> request({
    @required String url,
    @required String method,
    Map body,
    Map headers
  }) async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    final authorizedHeaders = headers ?? {}..addAll({'x-access-token': token});
    await decoratee.request(url: url, method: method, body: body, headers: authorizedHeaders);
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage{}
class HttpClientSpy extends Mock implements HttpClient{}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  AutorizeHttpClientDecorator sut;
  HttpClientSpy httpClient;
  String url;
  String method;
  Map body;
  String token;

  void mockToken() {
    token = faker.guid.guid();
    when(fetchSecureCacheStorage.fetchSecure(any)).thenAnswer((_) async => token);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AutorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      decoratee: httpClient);
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};

    mockToken();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {

    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  
  });

  test('Should call decoratee with access token on header', () async {

    await sut.request(url: url, method: method, body: body);
    verify(httpClient.request(url: url, method: method, body: body, headers: {'x-access-token': token})).called(1);

    await sut.request(url: url, method: method, body: body, headers: {'any_header': 'any_value'});
    verify(httpClient.request(url: url, method: method, body: body, headers: {'x-access-token': token, 'any_header': 'any_value'})).called(1);
  
  });
}
    
    