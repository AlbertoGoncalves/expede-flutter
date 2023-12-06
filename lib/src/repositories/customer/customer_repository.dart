import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/model/customer_model.dart';

abstract interface class CustomerRepository {
  Future<Either<RepositoryException, List<CustomerModel>>> getCustomers(
      int companyId);

  Future<Either<RepositoryException, Nil>> registerCustomer(
      ({
        int companyId,
        String name,
        String email,
        String address,
      }) customerModel);

  Future<Either<RepositoryException, Nil>> alterCustomer(
      ({
        int id,
        int companyId,
        String name,
        String email,
        String address,
      }) customerModel);

  Future<Either<RepositoryException, Nil>> deleteCustomer(
      ({int id}) customerModel);
}
