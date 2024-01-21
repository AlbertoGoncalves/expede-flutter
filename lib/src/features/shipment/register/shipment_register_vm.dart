import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/shipment/register/shipment_register_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shipment_register_vm.g.dart';

@riverpod
class ShipmentRegisterVm extends _$ShipmentRegisterVm {
  @override
  ShipmentRegisterState build() => ShipmentRegisterState.initial();

  Future<void> register(
      {DateTime? sendDate,
      DateTime? arrivalDate,
      int? hour,
      String? driver,
      String? modalType,
      String? transport}) async {
    final shipmentRepository = ref.watch(shipmentRepositoryProvider);

    final CompanyModel(:id) = await ref.watch(getMyCompanyProvider.future);

    final UserModel(id: idUser) = await ref.watch(getMeProvider.future);

    final dto = (
      companyId: id,
      userId: idUser,
      sendDate: sendDate!,
      arrivalDate: arrivalDate!,
      hour: hour!,
      driver: driver!,
      modalType: modalType!,
      transport: transport!
    );

    final resulRegister = await shipmentRepository.registerShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ShipmentRegisterStateStatus.error);
    }
  }

  Future<void> alter(
      {int? id,
      DateTime? sendDate,
      DateTime? arrivalDate,
      int? hour,
      String? driver,
      String? modalType,
      String? transport}) async {
    final shipmentRepository = ref.watch(shipmentRepositoryProvider);

    final CompanyModel(id: companyId) =
        await ref.watch(getMyCompanyProvider.future);

    final UserModel(id: idUser) = await ref.watch(getMeProvider.future);

    final dto = (
      id: id!,
      companyId: companyId,
      userId: idUser,
      sendDate: sendDate!,
      arrivalDate: arrivalDate!,
      hour: hour!,
      driver: driver!,
      modalType: modalType!,
      transport: transport!
    );

    final resulRegister = await shipmentRepository.alterShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ShipmentRegisterStateStatus.error);
    }
  }

  Future<void> delete({
    int? id,
  }) async {
    final shipmentRepository = ref.watch(shipmentRepositoryProvider);

    final dto = (id: id!);

    final resulRegister = await shipmentRepository.deleteShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ShipmentRegisterStateStatus.error);
    }
  }
}
