import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter{
  final LoadCurrentAccount loadCurrentAccount;
  var _navigateTo = RxString();

  GetxSplashPresenter({ @required this.loadCurrentAccount });

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount({ int durationInSeconds = 2 }) async{
    await Future.delayed(Duration(seconds: durationInSeconds));
    try{
    final account = await loadCurrentAccount.load();
    _navigateTo.value = account?.token == null ? '/login' : '/surveys';
    } catch(error) {
      _navigateTo.value = '/login';
    }
  }
}