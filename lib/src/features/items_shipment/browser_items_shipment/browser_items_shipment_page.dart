import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/home/widgets/home_header.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_state.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_vm.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/widgets/home_tems_shipment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserItemsShipmentPage extends ConsumerWidget {
  const BrowserItemsShipmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserItemsShipmentState = ref.watch(browserItemsShipmentVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/item_shipment/register');
          ref.invalidate(getMeProvider);
          ref.invalidate(browserItemsShipmentVmProvider);
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            AppIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: browserItemsShipmentState.when(
        data: (BrowserItemsShipmentState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(
                  textHeader: 'Itens do Carregamento',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeItemsShipmentTile(itemsShipment: data.itemsShipment[index]),
                  childCount: data.itemsShipment.length,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar Itens do Carregamento',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar pagina'),
          );
        },
        loading: () {
          return const AppLoader();
        },
      ),
    );
  }
}
