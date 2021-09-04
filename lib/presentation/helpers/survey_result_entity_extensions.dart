import '../../domain/entities/entities.dart'; 

import '../../ui/pages/pages.dart';

extension SurveyResultEntityExtensions on SurveyResultEntity {
  SurveyResultViewModel toViewModel() => SurveyResultViewModel(
    surveyId: surveyId,
    question: question,
    answers: answers.map((answer) => answer.toViewModel()).toList()
  );
}

extension SurveyAnswertEntityExtensions on SurveyAnswerEntity {
  SurveyAnswerViewModel toViewModel() => SurveyAnswerViewModel(
      image: image,
      answer: answer,
      isCurrentAnswer: isCurrentAnswer,
      percent: '$percent%'
  );
}