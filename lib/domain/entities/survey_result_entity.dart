import 'package:ForDev/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyResultEntity extends Equatable{
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;

  List get props => ['surveyId', 'question', 'answers'];

  SurveyResultEntity({ 
    @required this.surveyId, 
    @required this.question, 
    @required this.answers 
  });
}