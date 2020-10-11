import 'package:ForDev/domain/helpers/helpers.dart';

enum DomainError {
  unexpected,
  invalidCredentials
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch(this) {
      case DomainError.invalidCredentials: return 'Credenciais inválidas.';
      default: '';
    }
  }
}