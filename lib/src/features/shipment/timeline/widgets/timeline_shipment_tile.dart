import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_vm.dart';
import 'package:expede/src/features/shipment/register/shipment_register_vm.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimelineShipmentTile extends ConsumerWidget {
  final ShipmentModel shipment;
  final Color cor;
  final int showFilter;

  const TimelineShipmentTile(
      {super.key, required this.shipment, required this.cor})
      : showFilter = 0;

  const TimelineShipmentTile.send(
      {super.key, required this.shipment, required this.cor})
      : showFilter = 1;

  const TimelineShipmentTile.arrival(
      {super.key, required this.shipment, required this.cor})
      : showFilter = 2;

  const TimelineShipmentTile.delay(
      {super.key, required this.shipment, required this.cor})
      : showFilter = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentRegisterVM = ref.watch(shipmentRegisterVmProvider.notifier);
    final dateFormat = DateFormat('dd/MM/yyyy');
    return ListTile(
      tileColor: cor,
      subtitle: Text("Localizador: ${shipment.transport}"),
      trailing: Container(
        padding: const EdgeInsets.all(5.0),
        child: switch (showFilter) {
          1 => Column(
              children: [
                const Text("Envio",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                Text(dateFormat.format(shipment.sendDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          2 => Column(
              children: [
                const Text("Chegada",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                Text(dateFormat.format(shipment.arrivalDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          3 => Column(
              children: [
                const Text("Chegada",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                Text(dateFormat.format(shipment.arrivalDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorsConstants.red,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          _ => const Text(""),
        },
      ),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: switch (shipment.modalType) {
              'Rodoviário' => const AssetImage(ImageConstants.truck),
              'Ferroviário' => const AssetImage(ImageConstants.train),
              'Aéreo' => const AssetImage(ImageConstants.planes),
              'Aquaviário' => const AssetImage(ImageConstants.ship),
              _ => const AssetImage(ImageConstants.avatar),
            },
          ),
        ),
      ),
      title: Text(
        "Cod.${shipment.id.toString()}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      // onTap: () {
      // Navigator.of(context)
      //     .pushNamed('/home/browser/items_for_shipment', arguments: shipment);},
      onTap: () async {
        await Navigator.of(context)
            .pushNamed('/shipment/register', arguments: shipment);
      },
    );

    Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      width: 200,
      // height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (shipment.modalType) {
                  'Rodoviário' => const AssetImage(ImageConstants.truck),
                  'Ferroviário' => const AssetImage(ImageConstants.train),
                  'Aéreo' => const AssetImage(ImageConstants.planes),
                  'Aquaviário' => const AssetImage(ImageConstants.ship),
                  _ => const AssetImage(ImageConstants.avatar),
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cod.${shipment.id.toString()}-${shipment.transport}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            '/home/browser/items_for_shipment',
                            arguments: shipment);
                      },
                      child: const Text('itens do carregamento'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                            '/shipment/register',
                            arguments: shipment);
                      },
                      child: const Icon(
                        AppIcons.penEdit,
                        size: 25,
                        color: ColorsConstants.brow,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () async {
                        Messages.showSuccess(
                            'Carga excluido com sucesso', context);
                        await shipmentRegisterVM.delete(id: shipment.id);
                        ref.invalidate(browserShipmentVmProvider);
                        ref.invalidate(shipmentRegisterVmProvider);
                      },
                      child: const Icon(
                        AppIcons.trash,
                        size: 25,
                        color: ColorsConstants.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
