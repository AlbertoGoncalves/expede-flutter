enum ItemShipmentRegisterStateStatus {
  initial,
  success,
  error,
}

class ItemShipmentRegisterState {
  final ItemShipmentRegisterStateStatus status;

  ItemShipmentRegisterState({
    required this.status,
  });

  ItemShipmentRegisterState.initial()
      : this(status: ItemShipmentRegisterStateStatus.initial);

  ItemShipmentRegisterState copyWith({
    ItemShipmentRegisterStateStatus? status,
  }) {
    return ItemShipmentRegisterState(
      status: status ?? this.status,
    );
  }
}
