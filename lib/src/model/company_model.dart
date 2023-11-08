class CompanyModel {
  final int id;
  final String company;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;

  CompanyModel({
    required this.id,
    required this.company,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });

  factory CompanyModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'company': String company,
        'email': String email,
        'opening_days': final List openingDays,
        'opening_hours': final List openingHours,
      } =>
        CompanyModel(
          id: id,
          company: company,
          email: email,
          openingDays: openingDays.cast<String>(),
          openingHours: openingHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}




// class CompanyModel {
//   final int id;
//   final String name;
//   final String email;
//   final List<String> openingDays;
//   final List<int> openingHours;

//   CompanyModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.openingDays,
//     required this.openingHours,
//   });

//   factory CompanyModel.fromMap(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'id': int id,
//         'name': String name,
//         'email': String email,
//         'opening_days': final List openingDays,
//         'opening_hours': final List openingHours,
//       } =>
//         CompanyModel(
//           id: id,
//           name: name,
//           email: email,
//           openingDays: openingDays.cast<String>(),
//           openingHours: openingHours.cast<int>(),
//         ),
//       _ => throw ArgumentError('Invalid Json'),
//     };
//   }
// }