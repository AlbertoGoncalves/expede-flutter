import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/model/shipment_model.dart';

abstract interface class ShipmentRepository {
  Future<Either<RepositoryException, List<ShipmentModel>>> getShipments(
      int companyId, int? userId);

  Future<Either<RepositoryException, Nil>> registerShipment(
      ({
        int companyId,
        int userId,
        DateTime date,
        int hour,
        String driver,
        String modalType,
        String transport
      }) itemShipmentModel);

  Future<Either<RepositoryException, Nil>> alterShipment(
      ({
        int id,
        int companyId,
        int userId,
        DateTime? date,
        int? hour,
        String driver,
        String modalType,
        String transport
      }) itemShipmentModel);

  Future<Either<RepositoryException, Nil>> deleteShipment(({int id}) itemShipmentModel);
}
