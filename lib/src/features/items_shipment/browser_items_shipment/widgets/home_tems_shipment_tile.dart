import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_vm.dart';
import 'package:expede/src/features/items_shipment/register/item_shipment_register_vm.dart';
import 'package:expede/src/model/item_shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeItemsShipmentTile extends ConsumerWidget {
  final ItemShipmentModel itemsShipment;

  const HomeItemsShipmentTile({super.key, required this.itemsShipment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemShipmentRegisterVM =
        ref.watch(itemShipmentRegisterVmProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      // width: 200,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              itemsShipment.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                      '/item_shipment/register',
                      arguments: itemsShipment);
                },
                child: const Icon(
                  AppIcons.penEdit,
                  size: 25,
                  color: ColorsConstants.brow,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () async {
                  Messages.showSuccess('Item da carga excluido com sucesso', context);
                  await itemShipmentRegisterVM.delete(id: itemsShipment.id);
                  ref.invalidate(browserItemsShipmentVmProvider);
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
    );
  }
}
