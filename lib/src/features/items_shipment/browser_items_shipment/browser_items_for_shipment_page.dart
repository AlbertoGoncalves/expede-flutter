import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/home_header.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/browser_items_shipment_vm.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/items_for_shipment_provider.dart';
import 'package:expede/src/features/items_shipment/browser_items_shipment/widgets/home_tems_shipment_tile.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserItemsForShipmentPage extends ConsumerWidget {
  const BrowserItemsForShipmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final shipment = ModalRoute.of(context)!.settings.arguments as ShipmentModel;
    
    final browserItemsShipmentState = ref.watch(getItemsForShipmentProvider(shipment.id));   
       
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
        data: (data) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HomeHeader(
                  textHeader: 'Itens do Carregamento Cod. ${shipment.id}',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeItemsShipmentTile(itemsShipment: data[index]),
                  childCount: data.length,
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
