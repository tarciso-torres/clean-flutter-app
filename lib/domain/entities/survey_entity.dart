import 'package:meta/meta.dart';

class SurveytEntity{
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;

  SurveytEntity({ 
    @required this.id, 
    @required this.question, 
    @required this.dateTime, 
    @required this.didAnswer 
  });
}