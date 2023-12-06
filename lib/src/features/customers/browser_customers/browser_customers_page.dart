import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/customers/browser_customers/browser_customers_state.dart';
import 'package:expede/src/features/customers/browser_customers/browser_customers_vm.dart';
import 'package:expede/src/features/customers/browser_customers/widgets/home_customers_tile.dart';
import 'package:expede/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserCustomersPage extends ConsumerWidget {
  const BrowserCustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserCustomersState = ref.watch(browserCustomersVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/customer/register');
          ref.invalidate(getMeProvider);
          ref.invalidate(browserCustomersVmProvider);
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
      body: browserCustomersState.when(
        data: (BrowserCustomersState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(
                  textHeader: 'Clientes',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeCustomersTile(customer: data.customers[index]),
                  childCount: data.customers.length,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar Clientes',
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
