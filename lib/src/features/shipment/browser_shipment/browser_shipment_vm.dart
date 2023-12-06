import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browser_shipment_vm.g.dart';

@riverpod
class BrowserShipmentVm extends _$BrowserShipmentVm {
  @override
  Future<BrowserShipmentState> build() async {
    final repository = ref.read(shipmentRepositoryProvider);
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);
    final UserModel(id: userId) = await ref.read(getMeProvider.future);

    final shipmentResult = await repository.getShipments(companyId, userId);

    switch (shipmentResult) {
      case Success(value: final shipmentData):
        final shipment = <ShipmentModel>[];
        shipment.addAll(shipmentData);

        return BrowserShipmentState(
            status: BrowserShipmentStateStatus.loaded, shipment: shipment);
      case Failure():
        return BrowserShipmentState(
            status: BrowserShipmentStateStatus.error, shipment: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
