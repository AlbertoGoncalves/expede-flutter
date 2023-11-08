import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/rest_client/rest_client.dart';
import 'package:expede/src/core/ui/app_nav_global_key.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:expede/src/repositories/company_repository.dart';
import 'package:expede/src/repositories/company_repository_impl.dart';
import 'package:expede/src/repositories/customer/customer_repository.dart';
import 'package:expede/src/repositories/customer/customer_repository_impl.dart';
import 'package:expede/src/repositories/schedule/schedule_repository.dart';
import 'package:expede/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:expede/src/repositories/user/user_repository.dart';
import 'package:expede/src/repositories/user/user_repository_impl.dart';
import 'package:expede/src/services/users_login/user_login_service.dart';
import 'package:expede/src/services/users_login/user_login_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(CustomerRepositoryRef ref) =>
    CustomerRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(userRepositoryProvider).me();

  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
CompanyRepository companyRepository(CompanyRepositoryRef ref) =>
    CompanyRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<CompanyModel> getMyCompany(GetMyCompanyRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final companyRepository = ref.watch(companyRepositoryProvider);
  final result = await companyRepository.getMyCompany(userModel);

  return switch (result) {
    Success(value: final company) => company,
    Failure(:final exception) => throw exception
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyCompanyProvider);

  Navigator.of(AppNavGlobalKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil(
    "/auth/login",
    (route) => false,
  );
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.read(restClientProvider));
