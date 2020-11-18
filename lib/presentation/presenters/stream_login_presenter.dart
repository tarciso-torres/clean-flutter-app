import 'dart:async';

import 'package:ForDev/ui/helpers/errors/errors.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  String mainError;
  String navigateTo;
  bool isLoading = false;

  bool get isFormValid => emailError == null
    && passwordError == null
    && email != null
    && password != null;
}
