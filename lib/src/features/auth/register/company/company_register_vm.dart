import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/auth/register/company/company_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_register_vm.g.dart';


@riverpod
class CompanyRegisterVm extends _$CompanyRegisterVm {
  @override
  CompanyRegisterState build() => CompanyRegisterState.initial();

  void addOrRemoveOpenHour(int hour) {
    final openingHours = state.openingHours;

    if (openingHours.contains(hour)) {
      openingHours.remove(hour);
    } else {
      openingHours.add(hour);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  void addOrRemoveOpenDay(String weekDays) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekDays)) {
      openingDays.remove(weekDays);
    } else {
      openingDays.add(weekDays);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  Future<void> register(String company, String email) async {
    final repository = ref.watch(companyRepositoryProvider);
    final CompanyRegisterState(:openingDays, :openingHours) = state;

    final dto = (
      company: company,
      email: email,
      openingDays: openingDays, 
      openingHours: openingHours
    ); 

    final registerResult = await repository.save(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMyCompanyProvider);
        state = state.copyWith(status: CompanyRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: CompanyRegisterStateStatus.error);
    }
  }
}
