import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/home_header.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_state.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_vm.dart';
import 'package:expede/src/features/employee/browser_employees/widgets/home_employees_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowserEmployeesPage extends ConsumerWidget {
  const BrowserEmployeesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(browserEmployeesVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () async {
          await Navigator.of(context).pushNamed('/employee/register');
          ref.invalidate(getMeProvider);
          ref.invalidate(browserEmployeesVmProvider);
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
      body: homeState.when(
        data: (BrowserEmployeesState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(
                  textHeader: 'Usuarios',
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeEmployeeTile(employee: data.employees[index]),
                  childCount: data.employees.length,
                ),
              ),
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
