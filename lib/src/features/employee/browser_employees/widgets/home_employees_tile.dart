import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/app_icons.dart';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_vm.dart';
import 'package:expede/src/features/employee/register/employee_register_vm.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeeTile extends ConsumerWidget {
  final UserModel employee;

  const HomeEmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(ImageConstants.avatar)
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed('/schedule', arguments: employee);
                    //   },
                    //   child: const Text('AGENDAR'),
                    // ),
                    // OutlinedButton(
                    //   style: OutlinedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed('/employee/schedule',
                    //         arguments: employee);
                    //   },
                    //   child: const Text('VER AGENDA'),
                    // ),
                    InkWell(
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                            '/employee/register',
                            arguments: employee);
                      },
                      child: const Icon(
                        AppIcons.penEdit,
                        size: 25,
                        color: ColorsConstants.brow,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () async {
                        Messages.showSuccess(
                            'Usuario excluido com sucesso', context);
                        await employeeRegisterVM.delete(id: employee.id);
                        ref.invalidate(browserEmployeesVmProvider);
                        ref.invalidate(employeeRegisterVmProvider);
                      },
                      child: const Icon(
                        AppIcons.trash,
                        size: 25,
                        color: ColorsConstants.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
