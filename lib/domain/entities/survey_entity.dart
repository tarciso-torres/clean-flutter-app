import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveytEntity extends Equatable{
  final String id;
  final String question;
  final DateTime dateTime;
  final bool didAnswer;

  List get props => ['id', 'question', 'dateTime', 'didAnswer'];

  SurveytEntity({ 
    @required this.id, 
    @required this.question, 
    @required this.dateTime, 
    @required this.didAnswer 
  });
}