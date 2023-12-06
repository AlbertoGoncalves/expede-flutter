import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/rest_client/rest_client.dart';
import 'package:expede/src/model/item_shipment_model.dart';
import 'package:expede/src/repositories/items_shipment/items_shipment_repository.dart';

class ItemsShipmentRepositoryImpl implements ItemShipmentRepository {
  final RestClient restClient;
  ItemsShipmentRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, List<ItemShipmentModel>>>
      getItemsShipments(int companyId, int shipmentId) async {
    try {
      Map<String, dynamic> filter = {};

      if (shipmentId == 0) {
        filter = {'company_id': companyId};
      } else {
        filter = {'company_id': companyId, "shipment_id": shipmentId};
      }
      final Response(:List data) =
          await restClient.auth.get('/items_shipment', queryParameters: filter);

      final itemsShipment =
          data.map((e) => ItemShipmentModel.fromMap(e)).toList();
      return Success(itemsShipment);
    } on DioException catch (e, s) {
      log('Erro ao buscar Itens do carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar Itens do carregamento'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter Itens do carregamentoes (Invalid Json)',
          error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar Itens do carregamento'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerItemShipment(
      ({
        int companyId,
        int? shipmentId,
        int clientId,
        String label,
        String tipo,
        DateTime date
      }) itemShipmentModel) async {
    try {
      await restClient.auth.post('/items_shipment/', data: {
        'company_id': itemShipmentModel.companyId,
        'shipment_id': itemShipmentModel.shipmentId,
        'client_id': itemShipmentModel.clientId,
        'label': itemShipmentModel.label,
        'tipo': itemShipmentModel.tipo,
        'date': itemShipmentModel.date.toIso8601String(),
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir Iten do carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao inserir Iten do carregamento'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> alterItemShipment(
      ({
        int id,
        int companyId,
        int? shipmentId,
        int clientId,
        String label,
        String tipo,
        DateTime date
      }) itemShipmentModel) async {
    try {
      await restClient.auth.patch('/items_shipment/${itemShipmentModel.id}', data: {
        'id': itemShipmentModel.id,
        'company_id': itemShipmentModel.companyId,
        'shipment_id': itemShipmentModel.shipmentId,
        'client_id': itemShipmentModel.clientId,
        'label': itemShipmentModel.label,
        'tipo': itemShipmentModel.tipo,
        'date': itemShipmentModel.date.toIso8601String(),
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao alterar Iten do carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao alterar Iten do carregamento'));
    }
  }

    @override
  Future<Either<RepositoryException, Nil>> deleteItemShipment(
      ({
        int id
      }) itemShipmentModel) async {
    try {
      await restClient.auth.delete('/items_shipment/${itemShipmentModel.id}', data: {
        'id': itemShipmentModel.id
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao deletar Iten do carregamento', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao deletar Iten do carregamento'));
    }
  }
}
