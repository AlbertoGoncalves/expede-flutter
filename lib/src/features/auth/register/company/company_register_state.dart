enum CompanyRegisterStateStatus {
  initial,
  success,
  error,
}

class CompanyRegisterState {
  final CompanyRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  CompanyRegisterState.initial()
      : this(
          status: CompanyRegisterStateStatus.initial,
          openingDays: <String>[],
          openingHours: <int>[],
        );

  CompanyRegisterState(
      {required this.status,
      required this.openingDays,
      required this.openingHours});

  CompanyRegisterState copyWith(
      {CompanyRegisterStateStatus? status,
      List<String>? openingDays,
      List<int>? openingHours}) {
    return CompanyRegisterState(
        status: status ?? this.status,
        openingDays: openingDays ?? this.openingDays,
        openingHours: openingHours ?? this.openingHours);
  }
}
