import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/home/widgets/home_header.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_state.dart';
import 'package:expede/src/features/shipment/browser_shipment/browser_shipment_vm.dart';
import 'package:expede/src/features/shipment/browser_shipment/widgets/home_shipment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserShipmentPage extends ConsumerWidget {
  const BrowserShipmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserShipmentState = ref.watch(browserShipmentVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/shipment/register');
          ref.invalidate(getMeProvider);
          ref.invalidate(browserShipmentVmProvider);
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
      body: browserShipmentState.when(
        data: (BrowserShipmentState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(
                  textHeader: 'Carregamento',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeShipmentTile(shipment: data.shipment[index]),
                  childCount: data.shipment.length,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar Carregamento',
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
