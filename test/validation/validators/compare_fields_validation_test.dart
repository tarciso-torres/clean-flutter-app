import 'package:test/test.dart';

import 'package:ForDev/validation/validators/validators.dart';

import 'package:ForDev/presentation/protocols/protocols.dart';


void main() {

  CompareFieldValidation sut;

  setUp(() {
    sut = CompareFieldValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if value is equals', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

}