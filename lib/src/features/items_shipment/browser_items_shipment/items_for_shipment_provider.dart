import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/item_shipment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_for_shipment_provider.g.dart';

@riverpod
Future<List<ItemShipmentModel>> getItemsForShipment(
    GetItemsForShipmentRef ref, int shipmentId) async {

  final repository = ref.read(itemsShipmentRepositoryProvider);

  final CompanyModel(id: companyId) =
      await ref.read(getMyCompanyProvider.future);

  final itemsShipmentResult = await repository.getItemsShipments(companyId, shipmentId);

  switch (itemsShipmentResult) {
    case Success(value: final itemsShipmentData):
      final itemsShipment = <ItemShipmentModel>[];
      itemsShipment.addAll(itemsShipmentData);
      return itemsShipment;
    case Failure(:final exception):
      throw exception;
  }
}
