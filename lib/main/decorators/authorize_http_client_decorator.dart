import 'package:meta/meta.dart';

import '../../data/cache/cache.dart';
import '../../data/http/http.dart';

class AutorizeHttpClientDecorator implements HttpClient{
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AutorizeHttpClientDecorator({ 
    @required this.fetchSecureCacheStorage,
    @required this.decoratee });

  Future<dynamic> request({
    @required String url,
    @required String method,
    Map body,
    Map headers
  }) async {
    try{
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    final authorizedHeaders = headers ?? {}..addAll({'x-access-token': token});
    return await decoratee.request(url: url, method: method, body: body, headers: authorizedHeaders);
    } on HttpError {
      rethrow;
    } catch(error) {
      throw HttpError.forbidden;
    }
  }
}