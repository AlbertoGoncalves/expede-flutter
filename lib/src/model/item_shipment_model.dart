class ItemShipmentModel {
  final int id;
  final int companyId;
  final int? shipmentId;
  final int clientId;
  final String label;
  final String tipo;
  final DateTime date;
  
  ItemShipmentModel({
    required this.id,
    required this.companyId,
    this.shipmentId,
    required this.clientId,
    required this.label,
    required this.tipo,
    required this.date,
  });

  factory ItemShipmentModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'company_id': final int companyId,
        'shipment_id': final int shipmentId,
        'client_id': final int clientId,
        'label': final String label,
        'tipo': final String tipo,
        'date': final String itemDate,
      } =>
        ItemShipmentModel(
          id: id,
          companyId: companyId,
          shipmentId: shipmentId,
          clientId: clientId,
          label: label,
          tipo: tipo,
          date: DateTime.parse(itemDate),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
