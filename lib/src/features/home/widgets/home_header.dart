import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool showFilter;
  final String textHeader;

  // OPÇÃO 01 CHAMANDO UM Widget com comportamento diferntes
  const HomeHeader({super.key, required this.textHeader}) : showFilter = true;
  const HomeHeader.withoutFilter({super.key, required this.textHeader})
      : showFilter = false;

  // OPÇÃO 02 CHAMANDO UM Widget com comportamento diferntes
  // const HomeHeader({super.key, this.showFilter = true}) ;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(getMyCompanyProvider);
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage(
              ImageConstants.backgroundChair,
            ),
            fit: BoxFit.cover,
            opacity: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          company.maybeWhen(
            data: (companyData) {
              return Row(
                children: [
                  Offstage(
                    offstage: !showFilter,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: ColorsConstants.brow,
                        size: 35,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      companyData.company,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  // const Expanded(
                  //   child: Text(
                  //     'editar',
                  //     style: TextStyle(
                  //       color: ColorsConstants.brow,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      ref.read(homeAdmVmProvider.notifier).logout();
                    },
                    icon: const Icon(
                      AppIcons.exit,
                      color: ColorsConstants.brow,
                      size: 32,
                    ),
                  ),
                ],
              );
            },
            orElse: () {
              return const Center(
                child: AppLoader(),
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          // const Text(
          //   'Bem Vindo',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          Text(
            textHeader,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const SizedBox(
              height: 24,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: const TextField(
              decoration: InputDecoration(
                label: Text(
                  'Buscar Carregamento',
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Icon(
                    AppIcons.search,
                    color: ColorsConstants.brow,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
