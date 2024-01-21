import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/employee/register/employee_register_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterADM(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrRemoveWorkDays(String weekDay) {
    final EmployeeRegisterState(:workDays) = state;

    if (workDays.contains(weekDay)) {
      workDays.remove(weekDay);
    } else {
      workDays.add(weekDay);
    }

    state = state.copyWith(workDays: workDays);
  }

  void addOrRemoveWorkHours(int weekHour) {
    final EmployeeRegisterState(:workHours) = state;

    if (workHours.contains(weekHour)) {
      workHours.remove(weekHour);
    } else {
      workHours.add(weekHour);
    }

    state = state.copyWith(workHours: workHours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerADM, :workDays, :workHours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:registerAdmAsEmployee, :registerEmployee) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resulRegister;

    if (registerADM) {
      final dto = (
        workDays: workDays,
        workHours: workHours,
      );

      resulRegister = await registerAdmAsEmployee(dto);
    } else {
      final CompanyModel(:id) =
          await ref.watch(getMyCompanyProvider.future);
      final dto = (
        companyId: id,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours
      );

      resulRegister = await registerEmployee(dto);
    }

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }

  Future<void> alter({int? id,String? name, String? email, String? password}) async {
    final EmployeeRegisterState(:registerADM, :workDays, :workHours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:alterUser) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resulRegister;

    if (registerADM) {
      final dto = (
        id: id!,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours
      );
      resulRegister = await alterUser(dto);
    } else {
      final dto = (
        id: id!,
        name: name!,
        email: email!,
        password: password!,
        workDays: workDays,
        workHours: workHours
      );
      resulRegister = await alterUser(dto);
    }
    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }

  Future<void> delete({int? id}) async {
    final EmployeeRegisterState(:registerADM, :workDays, :workHours) = state;
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final UserRepository(:deleteEmployee,) =
        ref.read(userRepositoryProvider);

    final Either<RepositoryException, Nil> resulRegister;

    if (registerADM) {
      final dto = (
        id: id!,
      );
      resulRegister = await deleteEmployee(dto);
    } else {

      final dto = (
        id: id!,
      );
      resulRegister = await deleteEmployee(dto);
    }

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: EmployeeRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }
}
