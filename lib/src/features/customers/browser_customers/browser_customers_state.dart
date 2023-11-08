import 'package:expede/src/model/customer_model.dart';

enum BrowserCustomersStateStatus { loaded, error }

class BrowserCustomersState {
  final BrowserCustomersStateStatus status;
  final List<CustomerModel> customers;

  BrowserCustomersState({required this.status, required this.customers});

  BrowserCustomersState copyWith({
    BrowserCustomersStateStatus? status,
    List<CustomerModel>? customers,
  }) {
    return BrowserCustomersState(
        status: status ?? this.status, customers: customers ?? this.customers);
  }
}
