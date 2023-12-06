import 'dart:developer';
import 'package:expede/src/core/constants/default_options.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_vm.dart';
import 'package:expede/src/features/items_shipment/register/item_shipment_register_state.dart';
import 'package:expede/src/features/items_shipment/register/item_shipment_register_vm.dart';
import 'package:expede/src/features/items_shipment/register/items_register_state.dart';
import 'package:expede/src/features/items_shipment/register/items_register_vm.dart';
import 'package:expede/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:expede/src/model/item_shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class ItemShipmentRegisterPage extends ConsumerStatefulWidget {
  const ItemShipmentRegisterPage({super.key});

  @override
  ConsumerState<ItemShipmentRegisterPage> createState() =>
      _ItemShipmentRegisterPageState();
}

class _ItemShipmentRegisterPageState
    extends ConsumerState<ItemShipmentRegisterPage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var dateTimeSelect = DateTime.now();
  var showCalendar = false;
  var registerOrAlter = true;
  int itemShipmentId = 0;

  final formKey = GlobalKey<FormState>();
  final labelEC = TextEditingController();
  final dateEC = TextEditingController();

  final dropValueTipo = ValueNotifier('');
  final dropOptionsTipo = ItemsShipmentsTypeOptions.typeOptions;

  final dropValueclientId = ValueNotifier('');
  final dropOptionsclientId = [];

  final dropValueShipmentId = ValueNotifier('');
  final dropOptionsShipmentId = [];

  @override
  void dispose() {
    labelEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final itemshipment =
          ModalRoute.of(context)!.settings.arguments as ItemShipmentModel;
      labelEC.text.isEmpty ? labelEC.text = itemshipment.label : labelEC.text;
      dateEC.text.isEmpty
          ? dateEC.text = dateFormat.format(itemshipment.date)
          : dateEC.text;
      dropValueTipo.value.isEmpty
          ? dropValueTipo.value = itemshipment.tipo.toString()
          : dropValueTipo.value;
      dropValueclientId.value.isEmpty
          ? dropValueclientId.value = itemshipment.clientId.toString()
          : dropValueclientId.value;
      dropValueShipmentId.value.isEmpty
          ? dropValueShipmentId.value = itemshipment.shipmentId.toString()
          : dropValueShipmentId.value;
      itemShipmentId == 0 ? itemShipmentId = itemshipment.id : itemShipmentId;

      registerOrAlter = false;
    }

    final itemShipmentRegisterVM =
        ref.watch(itemShipmentRegisterVmProvider.notifier);

    final itemsRegisterState = ref.watch(itemsRegisterVmProvider);

    ref.listen(itemShipmentRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case ItemShipmentRegisterStateStatus.initial:
          break;
        case ItemShipmentRegisterStateStatus.success:
        if(registerOrAlter){
            Messages.showSuccess('Item da carga cadastrado com sucesso', context);
        }else{
            Messages.showSuccess('Item da carga alterado com sucesso', context);
        }
        
          Navigator.of(context).pop();
          ref.invalidate(browserItemsShipmentVmProvider);
          ref.invalidate(itemShipmentRegisterVmProvider);
          ref.invalidate(itemsRegisterVmProvider);
        case ItemShipmentRegisterStateStatus.error:
          Messages.showError('Erro ao registrar Item da carga', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Carga'),
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
                        controller: labelEC,
                        validator: Validatorless.required(
                            'Descrição da carga obrigatoria'),
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          label: Text("Descrição"),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ValueListenableBuilder(
                          valueListenable: dropValueTipo,
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
                                hint: const Text('Selecione o tipo da carga'),
                                value: (value.isEmpty) ? null : value,
                                items: dropOptionsTipo
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (setValue) =>
                                    dropValueTipo.value = setValue.toString(),
                              ),
                            );
                          }),
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
                      itemsRegisterState.when(
                        data: (ItemsRegisterState data) {
                          final customerModel = data.customers;
                          final shipmentModel = data.shipment;
                          return Column(
                            children: [
                              Container(
                                // padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: ColorsConstants.grey,
                                  ),
                                ),
                                child: ValueListenableBuilder(
                                    valueListenable: dropValueclientId,
                                    builder: (
                                      BuildContext context,
                                      String value,
                                      _,
                                    ) {
                                      return DropdownButton<String>(
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
                                        hint: const Text('Selecione o Cliente'),
                                        value: (value.isEmpty) ? null : value,
                                        items: customerModel
                                            .map((e) => DropdownMenuItem(
                                                  value: e.id.toString(),
                                                  child:
                                                      Text("${e.id}-${e.name}"),
                                                ))
                                            .toList(),
                                        onChanged: (setValue) =>
                                            dropValueclientId.value =
                                                setValue.toString(),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                // padding: const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: ColorsConstants.grey,
                                  ),
                                ),
                                child: ValueListenableBuilder(
                                    valueListenable: dropValueShipmentId,
                                    builder: (
                                      BuildContext context,
                                      String value,
                                      _,
                                    ) {
                                      return DropdownButton<String>(
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
                                            'Selecione o Carregamento'),
                                        value: (value.isEmpty) ? null : value,
                                        items: shipmentModel
                                            .map((e) => DropdownMenuItem(
                                                  value: e.id.toString(),
                                                  child: Text(
                                                      "cod.${e.id} ${e.driver}-${e.transport}"),
                                                ))
                                            .toList(),
                                        onChanged: (setValue) =>
                                            dropValueShipmentId.value =
                                                setValue.toString(),
                                      );
                                    }),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          log('Erro ao carregar itens',
                              error: error, stackTrace: stackTrace);
                          return const Center(
                            child: Text('Erro ao carregar pagina'),
                          );
                        },
                        loading: () {
                          return const AppLoader();
                        },
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
                          final label = labelEC.text;
                          final tipo = dropValueTipo.value;
                          final clientId = dropValueclientId.value;
                          final shipmentId = dropValueShipmentId.value;
                          if (registerOrAlter) {
                            itemShipmentRegisterVM.register(
                              label: label,
                              tipo: tipo,
                              date: dateTimeSelect,
                              clientId: int.parse(clientId),
                              shipmentId: int.parse(shipmentId),
                            );
                          } else {
                            itemShipmentRegisterVM.alter(
                              id: itemShipmentId,
                              label: label,
                              tipo: tipo,
                              date: dateTimeSelect,
                              clientId: int.parse(clientId),
                              shipmentId: int.parse(shipmentId),
                            );
                          }
                      }
                    },
                    child: Text(
                      registerOrAlter ? 'Cadastrar Carga': 'Alterar Carga',
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
