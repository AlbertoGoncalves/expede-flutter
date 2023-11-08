import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/rest_client/rest_client.dart';
import 'package:expede/src/model/customer_model.dart';
import 'customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final RestClient restClient;
  CustomerRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, List<CustomerModel>>> getCustomers(
      int companyId) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/customers', queryParameters: {'company_id': companyId});

      final customers = data.map((e) => CustomerModel.fromMap(e)).toList();
      return Success(customers);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid Json)',
          error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar colaboradores'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerCustomer(
      ({
        int companyId,
        String name,
        String email,
        String address,
      }) customerModel) async {
    try {
      await restClient.auth.post('/customers/', data: {
        'company_id': customerModel.companyId,
        'name': customerModel.name,
        'email': customerModel.email,
        'address': customerModel.address,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir administrador como colaborador',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'));
    }
  }
}
