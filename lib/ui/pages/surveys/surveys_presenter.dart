import 'survey_viewmodel.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<List<SurveyViewModel>> get surveysStream;
  Stream<String> get navigateToStream;
  
  Future<void> loadData();
  void goToSurveyResult(String surveyId);
}