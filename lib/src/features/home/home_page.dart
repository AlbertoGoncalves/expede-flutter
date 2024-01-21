import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/home_header.dart';
import 'package:expede/src/features/home/adm/widgets/home_features_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(getMeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          me.maybeWhen(
            data: (userData) {
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    HomeHeader.withoutFilter(
                      textHeader: "Bem Vindo ${userData.name}",
                    ),
                    const HomeFeaturesSystem(),
                  ],
                ),
              );
            },
            orElse: () {
              return const Center(
                child: AppLoader(),
              );
            },
          ),
        ],
      ),
    );
  }
}
