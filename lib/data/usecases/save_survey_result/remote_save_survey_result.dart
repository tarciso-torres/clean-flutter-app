import 'package:ForDev/domain/usecases/load_survey_result.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';


class RemoteSaveSurveyResult{
  final String url;
  final HttpClient httpClient;

  RemoteSaveSurveyResult({ @required this.url, @required  this.httpClient });
  
  Future<SurveyResultEntity> save({String answer}) async {
    try {
      await httpClient.request(url: url, method: 'put', body: {'answer': answer});
    }on HttpError catch(error) {
      throw error == HttpError.forbidden
        ? DomainError.accessDenied
        : DomainError.unexpected;
    }
  }
}