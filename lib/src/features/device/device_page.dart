import 'package:expede/src/features/device/device_state.dart';
import 'package:expede/src/features/device/device_vm.dart';
import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicePage extends ConsumerStatefulWidget {
  const DevicePage({super.key});

  @override
  ConsumerState<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends ConsumerState<DevicePage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceVm = ref.watch(deviceVmProvider.notifier);

    ref.listen(deviceVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case DeviceStateStatus.initial:
          break;
        case DeviceStateStatus.success:
          Messages.showSuccess('Cliente cadastrado com sucesso', context);
          Navigator.of(context).pop();
          ref.invalidate(deviceVmProvider);
        case DeviceStateStatus.error:
          Messages.showError('Erro ao registrar Cliente', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Mqtt'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: nameEC,
                        // validator: Validatorless.required('Nome obrigatorio'),
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          label: Text("Nome"),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                  'Existem campos inválidos', context);
                            case true:
                              deviceVm.ledHigh(
                                clientIdentifier: "APPEXPESP0001",
                              );
                          }
                        },
                        child: const Text(
                          'LIGAR LED',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                  'Existem campos inválidos', context);
                            case true:
                              deviceVm.ledLow(
                                clientIdentifier: "APPEXPESP0001",
                              );
                          }
                        },
                        child: const Text(
                          'DESLIGAR LED',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
