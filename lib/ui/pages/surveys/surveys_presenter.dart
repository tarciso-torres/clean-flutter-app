import 'survey_viewmodel.dart';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<SurveyViewModel>> get loadSurveysController;
  
  Future<void> loadData();
}