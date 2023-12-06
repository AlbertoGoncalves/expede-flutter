enum DeviceStateStatus {
  initial,
  success,
  error,
}

class DeviceState {
  final DeviceStateStatus status;

  DeviceState({
    required this.status,
  });

  DeviceState.initial()
      : this(status: DeviceStateStatus.initial);

  DeviceState copyWith({
    DeviceStateStatus? status,
  }) {
    return DeviceState(
      status: status ?? this.status,
    );
  }
}
