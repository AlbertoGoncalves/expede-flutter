import 'package:expede/src/model/item_shipment_model.dart';

enum BrowserItemsShipmentStateStatus { loaded, error }

class BrowserItemsShipmentState {
  final BrowserItemsShipmentStateStatus status;
  final List<ItemShipmentModel> itemsShipment;

  BrowserItemsShipmentState({required this.status, required this.itemsShipment});

  BrowserItemsShipmentState copyWith({
    BrowserItemsShipmentStateStatus? status,
    List<ItemShipmentModel>? itemsShipment,
  }) {
    return BrowserItemsShipmentState(
        status: status ?? this.status, itemsShipment: itemsShipment ?? this.itemsShipment);
  }
}
