import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteSurveyAnswerModel extends Equatable{
  final String image;
  final String answer;
  final bool isCurrentAccountAnswer;
  final int percent;

  List get props => ['image', 'answer', 'isCurrentAccountAnswer', 'percent'];

  RemoteSurveyAnswerModel({
    this.image,
    @required this.answer,
    @required this.isCurrentAccountAnswer,
    @required this.percent
  });

  factory RemoteSurveyAnswerModel.fromJson(Map json) {
    if(!json.keys.toSet().containsAll(['answer', 'isCurrentAccountAnswer', 'percent'])){
      throw HttpError.invalidData;
    }
    return RemoteSurveyAnswerModel(
      image: json['image'],
      answer: json['answer'],
      isCurrentAccountAnswer: json['isCurrentAccountAnswer'],
      percent: json['percent'],
    );
  }
  

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
    image: image,
    answer: answer,
    isCurrentAnswer: isCurrentAccountAnswer,
    percent: percent
  );
}