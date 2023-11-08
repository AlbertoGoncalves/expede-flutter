import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browser_employees_vm.g.dart';

@riverpod
class BrowserEmployeesVm extends _$BrowserEmployeesVm {
  @override
  Future<BrowserEmployeesState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);
    final me = await ref.watch(getMeProvider.future);

    final emplyeesResult = await repository.getEmployees(companyId);

    switch (emplyeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];

        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        employees.addAll(employeesData);

        return BrowserEmployeesState(
            status: BrowserEmployeesStateStatus.loaded, employees: employees);
      case Failure():
        return BrowserEmployeesState(status: BrowserEmployeesStateStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
