import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/shipment/timeline/timeline_shipment_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_shipment_vm.g.dart';

@riverpod
class TimelineShipmentVm extends _$TimelineShipmentVm {
  @override
  Future<TimelineShipmentState> build() async {
    final repository = ref.read(shipmentRepositoryProvider);
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);
    final UserModel(id: userId) = await ref.read(getMeProvider.future);

    final shipmentResult = await repository.getShipments(companyId, userId);

    switch (shipmentResult) {
      case Success(value: final shipmentData):
        final shipmentSend = <ShipmentModel>[];
        final shipmentArrival = <ShipmentModel>[];
        
        shipmentSend.addAll(shipmentData);
        shipmentSend.sort((b, a) => a.sendDate.compareTo(b.sendDate));

        shipmentArrival.addAll(shipmentData);
        shipmentArrival.sort((a, b) => a.arrivalDate.compareTo(b.arrivalDate));

        return TimelineShipmentState(
            status: TimelineShipmentStateStatus.loaded, shipmentSend: shipmentSend, shipmentArrival: shipmentArrival);
      case Failure():
        return TimelineShipmentState(
            status: TimelineShipmentStateStatus.error, shipmentSend: [], shipmentArrival: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
