import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/customers/register/customer_register_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customer_register_vm.g.dart';

@riverpod
class CustomerRegisterVm extends _$CustomerRegisterVm {
  @override
  CustomerRegisterState build() => CustomerRegisterState.initial();

  Future<void> register({String? name, String? email, String? address}) async {
    final customerRepository = ref.watch(customerRepositoryProvider);

    final CompanyModel(:id) = await ref.watch(getMyCompanyProvider.future);

    final dto = (
      companyId: id,
      name: name!,
      email: email!,
      address: address!,
    );

    final resulRegister = await customerRepository.registerCustomer(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: CustomerRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: CustomerRegisterStateStatus.error);
    }
  }
}
