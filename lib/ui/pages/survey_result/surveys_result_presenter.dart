import 'package:ForDev/ui/pages/pages.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<bool> get isSessionExpiredStream;
  Stream<SurveyResultViewModel> get surveyResultStream;
  
  Future<void> loadData();
}