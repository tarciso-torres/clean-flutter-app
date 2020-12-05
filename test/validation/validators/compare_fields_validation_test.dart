import 'package:test/test.dart';

import 'package:ForDev/validation/validators/validators.dart';

import 'package:ForDev/presentation/protocols/protocols.dart';


void main() {

  CompareFieldValidation sut;

  setUp(() {
    sut = CompareFieldValidation(field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equals', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

  test('Should return null if values are equals', () {
    expect(sut.validate('any_value'), null);
  });

}