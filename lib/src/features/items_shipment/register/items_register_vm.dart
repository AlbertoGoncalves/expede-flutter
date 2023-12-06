import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/items_shipment/register/items_register_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/customer_model.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_register_vm.g.dart';

@riverpod
class ItemsRegisterVm extends _$ItemsRegisterVm {
  @override
  Future<ItemsRegisterState> build() async {
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);

    final UserModel(id: userId) = await ref.read(getMeProvider.future);

    final repositoryShipment = ref.read(shipmentRepositoryProvider);
    final shipmentResult =
        await repositoryShipment.getShipments(companyId, userId);
    
    final shipment = <ShipmentModel>[];
    switch (shipmentResult) {
      case Success(value: final shipmentData):    
        shipment.addAll(shipmentData);
      case Failure():
        return ItemsRegisterState(
            status: ItemsRegisterStateStatus.error,
            customers: [],
            shipment: []);
    }

    final repository = ref.read(customerRepositoryProvider);
    final customersResult = await repository.getCustomers(companyId);

    switch (customersResult) {
      case Success(value: final customersData):
        final customers = <CustomerModel>[];
        customers.addAll(customersData);

        return ItemsRegisterState(
            status: ItemsRegisterStateStatus.loaded, customers: customers, shipment: shipment);
      case Failure():
        return ItemsRegisterState(
            status: ItemsRegisterStateStatus.error, customers: [], shipment: []);
    }
  }
}
