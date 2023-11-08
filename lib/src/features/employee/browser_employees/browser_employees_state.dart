import 'package:expede/src/model/user_model.dart';

enum BrowserEmployeesStateStatus { loaded, error }

class BrowserEmployeesState {
  final BrowserEmployeesStateStatus status;
  final List<UserModel> employees;

  BrowserEmployeesState({required this.status, required this.employees});

  BrowserEmployeesState copyWith({
    BrowserEmployeesStateStatus? status,
    List<UserModel>? employees,
  }) {
    return BrowserEmployeesState(
        status: status ?? this.status, employees: employees ?? this.employees);
  }
}
