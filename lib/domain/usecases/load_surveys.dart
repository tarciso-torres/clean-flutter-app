import '../entities/entities.dart';

abstract class LoadSurveys {
  Future<List<SurveytEntity>> load();
}