import 'package:expede/src/model/customer_model.dart';
import 'package:expede/src/model/shipment_model.dart';

enum ItemsRegisterStateStatus { loaded, error }

class ItemsRegisterState {
  final ItemsRegisterStateStatus status;
  final List<CustomerModel> customers;
  final List<ShipmentModel> shipment;

  ItemsRegisterState(
      {required this.status, required this.customers, required this.shipment});

  ItemsRegisterState copyWith({
    ItemsRegisterStateStatus? status,
    List<CustomerModel>? customers,
    List<ShipmentModel>? itemsShipment,
  }) {
    return ItemsRegisterState(
        status: status ?? this.status,
        customers: customers ?? this.customers,
        shipment: shipment ?? this.shipment);
  }
}
