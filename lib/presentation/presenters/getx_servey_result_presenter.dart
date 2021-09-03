import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart'; 
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/pages.dart';

class GetxSurveyResultPresenter implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _isSessionExpired = RxBool();
  final _surveyResult = Rx<SurveyResultViewModel>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<bool> get isSessionExpiredStream => _isSessionExpired.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;

  GetxSurveyResultPresenter(
      {@required this.loadSurveyResult,
      @required this.saveSurveyResult,
      @required this.surveyId});

  Future<void> loadData() async {
    showResultOnAction(() => loadSurveyResult.loadBySurvey(surveyId: surveyId));
  }

  @override
  Future<void> save({@required String answer}) async {
    showResultOnAction(() => saveSurveyResult.save(answer: answer));
  }

  Future<void> showResultOnAction(Future<SurveyResultEntity> action()) async {
    try {
      _isLoading.value = true;
      final surveyResult = await action();
      _surveyResult.value = SurveyResultViewModel(
          surveyId: surveyResult.surveyId,
          question: surveyResult.question,
          answers: surveyResult.answers
              .map((answer) => SurveyAnswerViewModel(
                  image: answer.image,
                  answer: answer.answer,
                  isCurrentAnswer: answer.isCurrentAnswer,
                  percent: '${answer.percent}%'))
              .toList());
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _isSessionExpired.value = true;
      } else {
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
