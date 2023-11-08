import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/model/schedule_model.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int companyId,
        int userId,
        String clientName,
        DateTime date,
        int time
      }) scheduleDate);

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filter);
}
