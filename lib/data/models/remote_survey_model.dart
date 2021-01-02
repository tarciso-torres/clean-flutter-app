import '../../domain/entities/entities.dart';

import 'package:meta/meta.dart';

import '../http/http.dart';

class RemoteSurveyModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  RemoteSurveyModel({
    @required this.id,
    @required this.question,
    @required this.date,
    @required this.didAnswer
    });

  factory RemoteSurveyModel.fromJson(Map json) {

    return RemoteSurveyModel(
      id: json['id'],
      question: json['question'],
      date: json['date'],
      didAnswer: json['didAnswer'],
    );
  }
  

  SurveytEntity toEntity() => SurveytEntity(
    id: id,
    question: question,
    dateTime: DateTime.parse(date),
    didAnswer: didAnswer,
  );
}