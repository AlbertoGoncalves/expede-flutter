import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_vm.dart';
import 'package:expede/src/features/shipment/register/shipment_register_vm.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeShipmentTile extends ConsumerWidget {
  final ShipmentModel shipment;

  const HomeShipmentTile({super.key, required this.shipment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentRegisterVM = ref.watch(shipmentRegisterVmProvider.notifier);
    return Container(
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
