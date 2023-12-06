class ShipmentModel {
  final int id;
  final int companyId;
  final int userId;
  final DateTime date;
  final int hour;
  final String driver;
  final String modalType;
  final String transport;
  
  
  ShipmentModel({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.date,
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
        'date': final String date,
        'time': final int hour,
        'driver': final String driver,
        'modal_type': final String modalType,
        'transport': final String transport,
      } =>
        ShipmentModel(
          id: id,
          companyId: companyId,
          userId: userId,
          date: DateTime.parse(date),
          hour: hour,
          driver: driver,
          modalType: modalType,
          transport: transport
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
