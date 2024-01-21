import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shipments_schedule_vm.g.dart';


@riverpod
class ShipmentsScheduleVm extends _$ShipmentsScheduleVm {

  Future<Either<RepositoryException, List<ShipmentModel>>> _getSchedules(int? id, int companyId, DateTime date, int? userId){
  final repository = ref.read(shipmentRepositoryProvider);
  return repository.findScheduleByDate((id: id, companyId: companyId, date: date, userId: userId));
  }
 
 @override
  Future<List<ShipmentModel>> build(int? id, int companyId, DateTime date, int? userId) async {
    final scheduleListResult = await _getSchedules(id, companyId, date, userId);
    return switch (scheduleListResult) {
      Success(value: final schedules) => schedules,
      Failure(:final exception) => throw Exception(exception)
    };
  }
  

  Future<void> changeDate(int? id, int companyId, DateTime date, int? userId) async {
    final scheduleListResult = await _getSchedules(id, companyId, date, userId);
    state = switch (scheduleListResult) {
      Success(value: final schedules) => AsyncData(schedules),
      Failure(:final exception) => AsyncError(Exception(exception), StackTrace.current)
    };
  }
}
