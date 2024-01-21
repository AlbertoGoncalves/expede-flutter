class ShipmentModel {
  final int id;
  final int companyId;
  final int userId;
  final DateTime sendDate;
  final DateTime arrivalDate;
  final int hour;
  final String driver;
  final String modalType;
  final String transport;
  
  
  ShipmentModel({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.sendDate,
    required this.arrivalDate,
    required this.hour,
    required this.driver,
    required this.modalType,
    required this.transport,
  });

  factory ShipmentModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'company_id': final int companyId,
        'user_id': final int userId,
        'send_date': final String sendDate,
        'arrival_date': final String arrivalDate,
        'time': final int hour,
        'driver': final String driver,
        'modal_type': final String modalType,
        'transport': final String transport,
      } =>
        ShipmentModel(
          id: id,
          companyId: companyId,
          userId: userId,
          sendDate: DateTime.parse(sendDate),
          arrivalDate: DateTime.parse(arrivalDate),
          hour: hour,
          driver: driver,
          modalType: modalType,
          transport: transport
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
