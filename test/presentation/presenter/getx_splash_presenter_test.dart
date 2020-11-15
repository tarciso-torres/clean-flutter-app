import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/usecases/usecases.dart';

import 'package:ForDev/ui/pages/pages.dart';


class GetxSplashPresenter implements SplashPresenter{
  final LoadCurrentAccount loadCurrentAccount;
  var _navigateTo = RxString();

  GetxSplashPresenter({ @required this.loadCurrentAccount });

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount() async{
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

void main() {

  GetxSplashPresenter sut;
  LoadCurrentAccountSpy loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}