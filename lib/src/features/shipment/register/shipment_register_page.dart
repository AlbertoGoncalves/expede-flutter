import 'package:expede/src/core/constants/default_options.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:expede/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_vm.dart';
import 'package:expede/src/features/shipment/register/shipment_register_state.dart';
import 'package:expede/src/features/shipment/register/shipment_register_vm.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class ShipmentRegisterPage extends ConsumerStatefulWidget {
  const ShipmentRegisterPage({super.key});

  @override
  ConsumerState<ShipmentRegisterPage> createState() =>
      _ShipmentRegisterPageState();
}

class _ShipmentRegisterPageState extends ConsumerState<ShipmentRegisterPage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var dateTimeSelect = DateTime.now();
  var showCalendar = false;
  var registerOrAlter = true;
  int shipmentId = 0;

  final formKey = GlobalKey<FormState>();
  final driverEC = TextEditingController();
  final transportEC = TextEditingController();
  final dateEC = TextEditingController();

  final dropValueModalType = ValueNotifier('');
  final dropOptionsModalType = ShipmentsTypeOptions.modalTypeOptions;

  @override
  void dispose() {
    driverEC.dispose();
    transportEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final shipment =
          ModalRoute.of(context)!.settings.arguments as ShipmentModel;
      driverEC.text.isEmpty ? driverEC.text = shipment.driver : driverEC.text;
      transportEC.text.isEmpty
          ? transportEC.text = shipment.transport
          : transportEC.text;
      dateEC.text.isEmpty
          ? dateEC.text = dateFormat.format(shipment.date)
          : dateEC.text;
      dropValueModalType.value.isEmpty
          ? dropValueModalType.value = shipment.modalType.toString()
          : dropValueModalType.value;
      shipmentId == 0 ? shipmentId = shipment.id : shipmentId;

      registerOrAlter = false;
    }

    final shipmentRegisterVM = ref.watch(shipmentRegisterVmProvider.notifier);

    ref.listen(shipmentRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case ShipmentRegisterStateStatus.initial:
          break;
        case ShipmentRegisterStateStatus.success:
          if (registerOrAlter) {
            Messages.showSuccess(
                'Carregamento cadastrado com sucesso', context);
          } else {
            Messages.showSuccess('Carregamento alterado com sucesso', context);
          }
          Navigator.of(context).pop();
          ref.invalidate(shipmentRegisterVmProvider);
          ref.invalidate(browserShipmentVmProvider);
        case ShipmentRegisterStateStatus.error:
          Messages.showError('Erro ao registrar Carregamento', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Carregamento'),
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
                      ValueListenableBuilder(
                          valueListenable: dropValueModalType,
                          builder: (
                            BuildContext context,
                            String value,
                            _,
                          ) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: ColorsConstants.grey,
                                ),
                              ),
                              child: DropdownButton<String>(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                isDense: true,
                                padding: const EdgeInsets.all(15),
                                isExpanded: true,
                                iconEnabledColor: ColorsConstants.brow,
                                hint: const Text(
                                    'Selecione o tipo do carregamento'),
                                value: (value.isEmpty) ? null : value,
                                items: dropOptionsModalType
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (setValue) => dropValueModalType
                                    .value = setValue.toString(),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: driverEC,
                        validator: Validatorless.required(
                            'Responssavel do Carregamento obrigatorio'),
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          label: Text("Responsável Carregamento"),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: transportEC,
                        validator: Validatorless.required(
                            'Identificação do meio de transporte obrigatoria'),
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          label: Text("Identificação meio de transporte"),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: dateEC,
                        validator: Validatorless.required('Data obrigatoria'),
                        onTapOutside: (_) => context.unfocus(),
                        onTap: () {
                          setState(() {
                            showCalendar = true;
                          });
                        },
                        decoration: const InputDecoration(
                          label: Text('Data de envio'),
                        ),
                      ),
                      Offstage(
                        offstage: !showCalendar,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            ScheduleCalendar(
                              cancelPressed: () {
                                setState(() {
                                  showCalendar = false;
                                });
                              },
                              okPressed: (DateTime value) {
                                setState(() {
                                  dateEC.text = dateFormat.format(value);
                                  dateTimeSelect = value;
                                  showCalendar = false;
                                });
                              },
                              workDays: const [],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
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
                          final modalType = dropValueModalType.value;
                          final driver = driverEC.text;
                          final transport = transportEC.text;
                          if (registerOrAlter) {
                            shipmentRegisterVM.register(
                                modalType: modalType,
                                driver: driver,
                                transport: transport,
                                date: dateTimeSelect,
                                hour: 1);
                          } else {
                            shipmentRegisterVM.alter(
                                id: shipmentId,
                                modalType: modalType,
                                driver: driver,
                                transport: transport,
                                date: dateTimeSelect,
                                hour: 1);
                          }
                      }
                    },
                    child: Text(
                      registerOrAlter ? 'Cadastrar Carregamento': 'Alterar Carregamento',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
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
