class CustomerModel {
  final int id;
  final int companyId;
  final String name;
  final String email;
  final String address;
  
  CustomerModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.email,
    required this.address,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'company_id': final int companyId,
        'name': final String name,
        'email': final String email,
        'address': final String address,
      } =>
        CustomerModel(
          id: id,
          companyId: companyId,
          name: name,
          email: email,
          address: address,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
