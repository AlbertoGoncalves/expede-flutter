import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/items_shipment/register/item_shipment_register_state.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_shipment_register_vm.g.dart';

@riverpod
class ItemShipmentRegisterVm extends _$ItemShipmentRegisterVm {
  @override
  ItemShipmentRegisterState build() => ItemShipmentRegisterState.initial();

  Future<void> register(
      {int? shipmentId,
      int? clientId,
      String? label,
      String? tipo,
      DateTime? date}) async {
    final itemsShipmentRepository = ref.watch(itemsShipmentRepositoryProvider);

    final CompanyModel(:id) = await ref.watch(getMyCompanyProvider.future);

    final dto = (
      companyId: id,
      shipmentId: shipmentId!,
      clientId: clientId!,
      label: label!,
      tipo: tipo!,
      date: date!,
    );

    final resulRegister =
        await itemsShipmentRepository.registerItemShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.error);
    }
  }

  Future<void> alter(
      {int? id,
      int? shipmentId,
      int? clientId,
      String? label,
      String? tipo,
      DateTime? date}) async {
    final itemsShipmentRepository = ref.watch(itemsShipmentRepositoryProvider);

    final CompanyModel(id: companyId) =
        await ref.watch(getMyCompanyProvider.future);

    final dto = (
      id: id!,
      companyId: companyId,
      shipmentId: shipmentId!,
      clientId: clientId!,
      label: label!,
      tipo: tipo!,
      date: date!,
    );

    final resulRegister = await itemsShipmentRepository.alterItemShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.error);
    }
  }

  Future<void> delete({int? id}) async {
    final itemsShipmentRepository = ref.watch(itemsShipmentRepositoryProvider);

    final dto = (id: id!);

    final resulRegister = await itemsShipmentRepository.deleteItemShipment(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.success);
      case Failure():
        state = state.copyWith(status: ItemShipmentRegisterStateStatus.error);
    }
  }
}
