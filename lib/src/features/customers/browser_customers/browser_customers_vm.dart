import 'package:asyncstate/asyncstate.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/customers/browser_customers/browser_customers_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/customer_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browser_customers_vm.g.dart';

@riverpod
class BrowserCustomersVm extends _$BrowserCustomersVm {
  @override
  Future<BrowserCustomersState> build() async {
    final repository = ref.read(customerRepositoryProvider);
    final CompanyModel(id: companyId) =
        await ref.read(getMyCompanyProvider.future);

    final customersResult = await repository.getCustomers(companyId);

    switch (customersResult) {
      case Success(value: final customersData):
        final customers = <CustomerModel>[];
        customers.addAll(customersData);

        return BrowserCustomersState(
            status: BrowserCustomersStateStatus.loaded, customers: customers);
      case Failure():
        return BrowserCustomersState(status: BrowserCustomersStateStatus.error, customers: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
