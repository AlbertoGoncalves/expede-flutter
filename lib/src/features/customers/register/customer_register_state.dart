enum CustomerRegisterStateStatus {
  initial,
  success,
  error,
}

class CustomerRegisterState {
  final CustomerRegisterStateStatus status;

  CustomerRegisterState({
    required this.status,
  });

  CustomerRegisterState.initial()
      : this(
          status: CustomerRegisterStateStatus.initial,
        );

  CustomerRegisterState copyWith({
    CustomerRegisterStateStatus? status,
  }) {
    return CustomerRegisterState(
      status: status ?? this.status,
    );
  }
}
