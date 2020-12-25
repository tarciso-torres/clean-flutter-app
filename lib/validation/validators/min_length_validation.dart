import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({ @required this.field, @required this.size });

  @override
  ValidationError validate(Map input) {
    return input[field] != null && input[field].length >= size ? null : ValidationError.invalidField;
  }
}