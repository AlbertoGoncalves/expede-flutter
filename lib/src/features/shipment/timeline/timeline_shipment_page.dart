import 'dart:developer';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/shipment/timeline/timeline_shipment_vm.dart';
import 'package:expede/src/features/shipment/timeline/timeline_shipment_state.dart';
import 'package:expede/src/features/shipment/timeline/widgets/timeline_shipment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineShipmentPage extends ConsumerWidget {
  const TimelineShipmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineShipmentState = ref.watch(timelineShipmentVmProvider);

    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = ColorsConstants.brow.withOpacity(0.05);
    final Color evenItemColor = ColorsConstants.brow.withOpacity(0.15);
    const int tabsCount = 3;

    List<String> titles = <String>[
      'Envio',
      'Chegada',
      'Em Atraso',
    ];

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cronograma de Carregamentos'),
          // This check specifies which nested Scrollable's scroll notification
          // should be listened to.
          //
          // When `ThemeData.useMaterial3` is true and scroll view has
          // scrolled underneath the app bar, this updates the app bar
          // background color and elevation.
          //
          // This sets `notification.depth == 1` to listen to the scroll
          // notification from the nested `ListView.builder`.
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Image.asset(
                  ImageConstants.packageSend,
                  width: 30,
                  height: 30,
                ),
                text: titles[0],
              ),
              Tab(
                icon: Image.asset(
                  ImageConstants.packageArrival,
                  width: 30,
                  height: 30,
                ),
                text: titles[1],
              ),
              Tab(
                icon: Image.asset(
                  ImageConstants.packageCheck,
                  width: 30,
                  height: 30,
                ),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: timelineShipmentState.when(
          data: (TimelineShipmentState data) {
            return TabBarView(
              children: <Widget>[
                ListView.builder(
                  itemCount: data.shipmentSend.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TimelineShipmentTile.send(
                      shipment: data.shipmentSend[index],
                      cor: index.isOdd ? oddItemColor : evenItemColor,
                    );
                  },
                ),
                ListView.builder(
                  itemCount: data.shipmentArrival.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TimelineShipmentTile.arrival(
                      shipment: data.shipmentArrival[index],
                      cor: index.isOdd ? oddItemColor : evenItemColor,
                    );
                  },
                ),
                ListView.builder(
                  itemCount: data.shipmentArrival.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TimelineShipmentTile.delay(
                      shipment: data.shipmentArrival[index],
                      cor: index.isOdd ? oddItemColor : evenItemColor,
                    );
                  },
                ),
              ],
            );
            // CustomScrollView(
            //   slivers: [
            //     const SliverToBoxAdapter(
            //       child: HomeHeader(
            //         textHeader: 'Carregamento',
            //       ),
            //     ),
            //     SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //         (context, index) =>
            //             TimelineShipmentTile(shipment: data.shipment[index]),
            //         childCount: data.shipment.length,
            //       ),
            //     ),
            //   ],
            // );
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
      ),
    );
  }
}
