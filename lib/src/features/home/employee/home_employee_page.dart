import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:expede/src/features/home/employee/home_employee_provider.dart';
import 'package:expede/src/features/home/widgets/home_header.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
          error: (error, stackTrace) {
            return const Center(
              child: Text('Erro ao carregar pagina'),
            );
          },
          loading: () => const AppLoader(),
          data: (user) {
            final UserModel(:name, :id) = user;
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: HomeHeader.withoutFilter(
                    textHeader: 'Bem vindo',
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const AvatarWidget(
                          hideUploadButton: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 7,
                          height: 108,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorsConstants.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final totalAsync = ref.watch(
                                      getTotalSchedulesTodayProvider(id));
                                  return totalAsync.when(
                                    error: (error, stackTrace) {
                                      return const Center(
                                        child: Text('Erro ao carregar pagina'),
                                      );
                                    },
                                    loading: () => const AppLoader(),
                                    skipLoadingOnRefresh: false,
                                    data: (totalSchedule) {
                                      return Text(
                                        '$totalSchedule',
                                        style: const TextStyle(
                                            fontSize: 32,
                                            color: ColorsConstants.brow,
                                            fontWeight: FontWeight.w600),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Text(
                                'Hoje',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56)),
                          onPressed: () async {
                            await Navigator.of(context)
                                .pushNamed('/schedule', arguments: user);
                            ref.invalidate(getTotalSchedulesTodayProvider);
                          },
                          child: const Text('AGENDAR CLIENTE'),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56)),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                '/employee/schedule',
                                arguments: user);
                          },
                          child: const Text('VER AGENDA'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
