import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add( AddAccountParams params );
}

class AddAccountParams extends Equatable{ 
  final String name;
  final String email;
  final String secret;
  final String password;
  final String passwordConfirmation;

  @override
  List get props => [name, email, secret,password, passwordConfirmation];

  AddAccountParams({ 
    @required this.name,
    @required this.email,
    @required this.secret,
    @required this.password,
    @required this.passwordConfirmation });
}