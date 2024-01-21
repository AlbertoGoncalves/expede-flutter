import 'package:expede/src/model/shipment_model.dart';

enum TimelineShipmentStateStatus { loaded, error }

class TimelineShipmentState {
  final TimelineShipmentStateStatus status;
  final List<ShipmentModel> shipmentSend;
  final List<ShipmentModel> shipmentArrival;

  TimelineShipmentState({required this.status, required this.shipmentSend, required this.shipmentArrival});

  TimelineShipmentState copyWith({
    TimelineShipmentStateStatus? status,
    List<ShipmentModel>? shipmentSend,
    List<ShipmentModel>? shipmentArrival,
  }) {
    return TimelineShipmentState(
        status: status ?? this.status, shipmentSend: shipmentSend ?? this.shipmentSend , shipmentArrival: shipmentArrival ?? this.shipmentArrival);
  }
}
