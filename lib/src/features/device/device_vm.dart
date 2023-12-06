import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/features/device/device_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_vm.g.dart';

@riverpod
class DeviceVm extends _$DeviceVm {
  @override
  DeviceState build() => DeviceState.initial();

  Future<void> ledHigh({
    String? clientIdentifier,
  }) async {
    final mqttRepository = ref.watch(mqttRepositoryProvider);

    final dto = (
      clientIdentifier: clientIdentifier!,
    );

    final resulRegister = await mqttRepository.ledHigh(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: DeviceStateStatus.success);
      case Failure():
        state = state.copyWith(status: DeviceStateStatus.error);
    }


  }

  Future<void> ledLow({
    String? clientIdentifier,
  }) async {
    final mqttRepository = ref.watch(mqttRepositoryProvider);

    final dto = (
      clientIdentifier: clientIdentifier!,
    );

    final resulRegister = await mqttRepository.ledLow(dto);

    switch (resulRegister) {
      case Success():
        state = state.copyWith(status: DeviceStateStatus.success);
      case Failure():
        state = state.copyWith(status: DeviceStateStatus.error);
    }
  }
}
