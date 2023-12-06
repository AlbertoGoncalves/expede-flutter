enum ShipmentRegisterStateStatus {
  initial,
  success,
  error,
}

class ShipmentRegisterState {
  final ShipmentRegisterStateStatus status;

  ShipmentRegisterState({
    required this.status,
  });

  ShipmentRegisterState.initial()
      : this(status: ShipmentRegisterStateStatus.initial);

  ShipmentRegisterState copyWith({
    ShipmentRegisterStateStatus? status,
  }) {
    return ShipmentRegisterState(
      status: status ?? this.status,
    );
  }
}
