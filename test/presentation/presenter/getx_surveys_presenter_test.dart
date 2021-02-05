import 'package:ForDev/domain/usecases/load_surveys.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({ @required this.loadSurveys });

  Future<void> loadData() async {
    loadSurveys.load();
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys{}

void main() {
  LoadSurveysSpy loadSurveys;
  GetxSurveysPresenter sut;

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
  });
  test('Should call LoadServeys on loadData', () async {
    

    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}