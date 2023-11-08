import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';

abstract interface class CompanyRepository {
  Future<Either<RepositoryException, Nil>> save(
      ({
        String company,
        String email,
        List<String> openingDays,
        List<int> openingHours,
      }) data);

  Future<Either<RepositoryException, CompanyModel>> getMyCompany(
      UserModel userModel);
}
