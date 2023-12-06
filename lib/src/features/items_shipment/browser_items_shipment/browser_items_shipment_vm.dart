import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/item_shipment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browser_items_shipment_vm.g.dart';

@riverpod
class BrowserItemsShipmentVm extends _$BrowserItemsShipmentVm {

  @override
  Future<BrowserItemsShipmentState> build() async {
    final repository = ref.read(itemsShipmentRepositoryProvider);
    
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);

    final itemsShipmentResult = await repository.getItemsShipments(companyId, 0);

    switch (itemsShipmentResult) {
      case Success(value: final itemsShipmentData):
        final itemsShipment = <ItemShipmentModel>[];
        itemsShipment.addAll(itemsShipmentData);

        return BrowserItemsShipmentState(
            status: BrowserItemsShipmentStateStatus.loaded, itemsShipment: itemsShipment);
      case Failure():
        return BrowserItemsShipmentState(status: BrowserItemsShipmentStateStatus.error, itemsShipment: []);
    }
  }  

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
