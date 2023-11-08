import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/rest_client/rest_client.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:expede/src/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final RestClient restClient;

  CompanyRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, CompanyModel>> getMyCompany(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/company',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(CompanyModel.fromMap(data));

      case UserModelEmployee():
        final Response(:data) =
            await restClient.auth.get('/company/${userModel.companyId}');
        return Success(CompanyModel.fromMap(data));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> save(
      ({
        String email,
        String company,
        List<String> openingDays,
        List<int> openingHours,
      }) data) async {
    try {
  await restClient.auth.post('/company', data: {
    'user_id': '#userAuthRef',
    'company': data.company,
    'email': data.email,
    'opening_days': data.openingDays,
    'opening_hours': data.openingHours,
  });
  return Success(nil);
} on DioException catch (e, s) {
      log('Erro ao registrar barbearia', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao registrar barbearia'),
      );
    }
  }
}
