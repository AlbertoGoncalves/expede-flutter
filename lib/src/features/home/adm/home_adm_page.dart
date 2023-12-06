import 'dart:developer';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/home/adm/home_adm_state.dart';
import 'package:expede/src/features/home/adm/home_adm_vm.dart';
import 'package:expede/src/features/home/adm/widgets/home_features_system.dart';
import 'package:expede/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      body: homeState.when(
        data: (HomeAdmState data) {
          return const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HomeHeader.withoutFilter(textHeader: 'Bem vindo',),
                    HomeFeaturesSystem(),
                  ],
                ),
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (context, index) =>
              //         HomeEmployeeTile(employee: data.employees[index]),
              //     childCount: data.employees.length,
              //   ),
              // ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar colaboradores',
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
