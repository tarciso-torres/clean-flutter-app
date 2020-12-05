import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class CompareFieldValidation implements FieldValidation {
  final String field;
  final String valueToCompare;

  CompareFieldValidation({ @required this.field, @required this.valueToCompare });

  @override
  ValidationError validate(String value) {
    return ValidationError.invalidField;
  }
}