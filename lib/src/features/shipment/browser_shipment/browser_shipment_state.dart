import 'package:expede/src/model/shipment_model.dart';

enum BrowserShipmentStateStatus { loaded, error }

class BrowserShipmentState {
  final BrowserShipmentStateStatus status;
  final List<ShipmentModel> shipment;

  BrowserShipmentState({required this.status, required this.shipment});

  BrowserShipmentState copyWith({
    BrowserShipmentStateStatus? status,
    List<ShipmentModel>? shipment,
  }) {
    return BrowserShipmentState(
        status: status ?? this.status, shipment: shipment ?? this.shipment);
  }
}
