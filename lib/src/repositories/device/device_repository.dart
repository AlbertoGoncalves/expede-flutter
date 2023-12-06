import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';

abstract interface class DeviceRepository {

  Future<Either<RepositoryException, Nil>> ledHigh(
      ({
        String clientIdentifier,
      }) mqttClient);

  Future<Either<RepositoryException, Nil>> ledLow(
      ({
        String clientIdentifier,
      }) mqttClient);
}
