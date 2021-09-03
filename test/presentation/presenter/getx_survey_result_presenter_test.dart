import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:ForDev/ui/helpers/helpers.dart';

import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/ui/pages/pages.dart';

import 'package:ForDev/presentation/presenters/presenters.dart';

class LoadSurveyResultSpy extends Mock implements LoadSurveyResult{}
class SaveSurveyResultSpy extends Mock implements SaveSurveyResult{}

void main() {
  GetxSurveyResultPresenter sut;
  LoadSurveyResultSpy loadSurveyResult;
  SaveSurveyResultSpy saveSurveyResult;
  SurveyResultEntity surveyResult;
  SurveyResultEntity saveResult;
  String surveyId;
  String answer;

  SurveyResultEntity mockValidData() => SurveyResultEntity(
    surveyId: faker.guid.guid(),
    question: faker.lorem.sentence(),
    answers: [
      SurveyAnswerEntity(
        image: faker.internet.httpUrl(),
        answer: faker.lorem.sentence(),
        percent: faker.randomGenerator.integer(100),
        isCurrentAnswer: faker.randomGenerator.boolean()
      ),
      SurveyAnswerEntity(
        answer: faker.lorem.sentence(),
        percent: faker.randomGenerator.integer(100),
        isCurrentAnswer: faker.randomGenerator.boolean()
      ),
    ]);

  PostExpectation mockLoadSurveyResultCall() => when(loadSurveyResult.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockLoadSurveyResult(SurveyResultEntity data) {
    surveyResult = data;
    mockLoadSurveyResultCall().thenAnswer((_) async => surveyResult);
  }

  mockLoadSurveyResultError(DomainError error) => mockLoadSurveyResultCall().thenThrow(error);

  PostExpectation mockSaveSurveyResultCall() => when(saveSurveyResult.save(answer: anyNamed('answer')));

  void mockSaveSurveyResult(SurveyResultEntity data) {
    saveResult = data;
    mockSaveSurveyResultCall().thenAnswer((_) async => saveResult);
  }

  mockSaveSurveyResultError(DomainError error) => mockSaveSurveyResultCall().thenThrow(error);

  setUp(() {
    surveyId = faker.guid.guid();
    answer = faker.lorem.sentence();
    loadSurveyResult = LoadSurveyResultSpy();
    saveSurveyResult = SaveSurveyResultSpy();
    sut = GetxSurveyResultPresenter(
      loadSurveyResult: loadSurveyResult,
      saveSurveyResult: saveSurveyResult,
      surveyId: surveyId
    );
    mockLoadSurveyResult(mockValidData());
    mockSaveSurveyResult(mockValidData());
  });

  group('loadData', () {
    test('Should call LoadServeyResult on loadData', () async {
      
      await sut.loadData();

      verify(loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
    });
    
    test('Should emit correct events on success', () async {

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(expectAsync1((result) => expect(result,
        SurveyResultViewModel(
          surveyId: surveyResult.surveyId,
          question: surveyResult.question,
          answers: [
            SurveyAnswerViewModel(
              image: surveyResult.answers[0].image,
              answer: surveyResult.answers[0].answer,
              isCurrentAnswer: surveyResult.answers[0].isCurrentAnswer,
              percent: '${surveyResult.answers[0].percent}%'
            ),
            SurveyAnswerViewModel(
              answer: surveyResult.answers[1].answer,
              isCurrentAnswer: surveyResult.answers[1].isCurrentAnswer,
              percent: '${surveyResult.answers[1].percent}%'
            ),
          ]
        )
      )));
      await sut.loadData();
    });
    
    test('Should emit correct events on failure', () async {

      mockLoadSurveyResultError(DomainError.unexpected);
      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(null, onError: expectAsync1((error) => expect(error, UIError.unexpected.description)));

      await sut.loadData();
    });
    
    test('Should emit correct events on access denied', () async {

      mockLoadSurveyResultError(DomainError.accessDenied);
      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      expectLater(sut.isSessionExpiredStream, emits(true));

      await sut.loadData();
    });
  });

  group('save', () {
    test('Should call SaveServeyResult on save', () async {
      
      await sut.save(answer: answer);

      verify(saveSurveyResult.save(answer: answer)).called(1);
    });
    
    test('Should emit correct events on success', () async {

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(expectAsync1((result) => expect(result,
        SurveyResultViewModel(
          surveyId: saveResult.surveyId,
          question: saveResult.question,
          answers: [
            SurveyAnswerViewModel(
              image: saveResult.answers[0].image,
              answer: saveResult.answers[0].answer,
              isCurrentAnswer: saveResult.answers[0].isCurrentAnswer,
              percent: '${saveResult.answers[0].percent}%'
            ),
            SurveyAnswerViewModel(
              answer: saveResult.answers[1].answer,
              isCurrentAnswer: saveResult.answers[1].isCurrentAnswer,
              percent: '${saveResult.answers[1].percent}%'
            ),
          ]
        )
      )));
      await sut.save(answer: answer);
    });
    
    test('Should emit correct events on failure', () async {

      mockSaveSurveyResultError(DomainError.unexpected);

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(null, onError: expectAsync1((error) => expect(error, UIError.unexpected.description)));

      await sut.save(answer: answer);
    });
    
    test('Should emit correct events on access denied', () async {

      mockSaveSurveyResultError(DomainError.accessDenied);

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      expectLater(sut.isSessionExpiredStream, emits(true));

      await sut.save(answer: answer);
    });

  });
}