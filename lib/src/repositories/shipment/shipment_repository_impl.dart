import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/rest_client/rest_client.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:expede/src/repositories/shipment/shipment_repository.dart';

class ShipmentRepositoryImpl implements ShipmentRepository {
  final RestClient restClient;
  ShipmentRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, List<ShipmentModel>>> getShipments(
      int companyId, int? userId) async {
    try {
      // final Response(:List data) = await restClient.auth
      //     .get('/shipments', queryParameters: {'company_id': companyId, 'client_id': clientId, 'user_id': userId});

      final Response(:List data) = await restClient.auth
          .get('/shipments', queryParameters: {'company_id': companyId});

      final shipment = data.map((e) => ShipmentModel.fromMap(e)).toList();
      return Success(shipment);
    } on DioException catch (e, s) {
      log('Erro ao buscar carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar carregamento'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter carregamentoes (Invalid Json)',
          error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar carregamento'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerShipment(
      ({
        int companyId,
        int userId,
        DateTime sendDate,
        DateTime arrivalDate,
        int? hour,
        String driver,
        String modalType,
        String transport
      }) shipmentModel) async {
    try {
      await restClient.auth.post('/shipments/', data: {
        'company_id': shipmentModel.companyId,
        'user_id': shipmentModel.userId,
        'send_date': shipmentModel.sendDate.toIso8601String(),
        'arrival_date': shipmentModel.arrivalDate.toIso8601String(),
        'time': shipmentModel.hour,
        'driver': shipmentModel.driver,
        'modal_type': shipmentModel.modalType,
        'transport': shipmentModel.transport,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao inserir carregamento'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> alterShipment(
      ({
        int id,
        int companyId,
        int userId,
        DateTime sendDate,
        DateTime arrivalDate,
        int? hour,
        String driver,
        String modalType,
        String transport
      }) shipmentModel) async {
    try {
      await restClient.auth.patch('/shipments/${shipmentModel.id}', data: {
        'id': shipmentModel.id,
        'company_id': shipmentModel.companyId,
        'user_id': shipmentModel.userId,
        'send_date': shipmentModel.sendDate.toIso8601String(),
        'arrival_date': shipmentModel.arrivalDate.toIso8601String(),
        'time': shipmentModel.hour,
        'driver': shipmentModel.driver,
        'modal_type': shipmentModel.modalType,
        'transport': shipmentModel.transport,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao alterar carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao alterar carregamento'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> deleteShipment(
      ({int? id}) shipmentModel) async {
    try {
      await restClient.auth.delete('/shipments/${shipmentModel.id}',
          data: {'id': shipmentModel.id});

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao deletar carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao deleter carregamento'));
    }
  }


    @override
  Future<Either<RepositoryException, List<ShipmentModel>>> findScheduleByDate(
      ({
        int? id,
        int companyId,
        DateTime date,
        int? userId,
      }) filter) async {
       List<ShipmentModel>schedules; 
    try {
      final Response(:List data) = await restClient.auth.get('/shipments',
          queryParameters: {
            'send_date': filter.date.toIso8601String(),
            'company_id': filter.companyId,
          });
      final sendDate = data.map((s) => ShipmentModel.fromMap(s)).toList();

      final Response(data:List data1) = await restClient.auth.get('/shipments',
          queryParameters: {
            'arrival_date': filter.date.toIso8601String(),
            'company_id': filter.companyId,
          });
      final arrivalDate = data1.map((s) => ShipmentModel.fromMap(s)).toList();

      schedules = sendDate + arrivalDate;

      return Success(schedules);
    } on DioException catch (e, s) {
      log('json invalido', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao buscar agendamento de uma data'),
      );
    } on ArgumentError catch (e, s) {
      log('json invalido', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'json invalido'),
      );
    }
  }

}
