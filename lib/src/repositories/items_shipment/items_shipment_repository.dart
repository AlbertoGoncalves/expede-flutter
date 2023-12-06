import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/model/item_shipment_model.dart';

abstract interface class ItemShipmentRepository {
  Future<Either<RepositoryException, List<ItemShipmentModel>>>
      getItemsShipments(int companyId, int shipmentId);

  Future<Either<RepositoryException, Nil>> registerItemShipment(
      ({
        int companyId,
        int? shipmentId,
        int clientId,
        String label,
        String tipo,
        DateTime date
      }) itemShipmentModel);

  Future<Either<RepositoryException, Nil>> alterItemShipment(
      ({
        int id,
        int companyId,
        int? shipmentId,
        int clientId,
        String label,
        String tipo,
        DateTime date
      }) itemShipmentModel);
  
    Future<Either<RepositoryException, Nil>> deleteItemShipment(
      ({
        int id
      }) itemShipmentModel);
}
