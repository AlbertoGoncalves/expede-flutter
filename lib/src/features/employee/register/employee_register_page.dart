import 'dart:developer';
import 'package:expede/src/core/providers/application_providers.dart';
import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:expede/src/core/ui/widgets/hours_panel.dart';
import 'package:expede/src/core/ui/widgets/weekdays_panel.dart';
import 'package:expede/src/features/employee/browser_employees/browser_employees_vm.dart';
import 'package:expede/src/features/employee/register/employee_register_state.dart';
import 'package:expede/src/features/employee/register/employee_register_vm.dart';
import 'package:expede/src/model/company_model.dart';
import 'package:expede/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  var registerOrAlter = true;
  int employeeId = 0;

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final employee = ModalRoute.of(context)!.settings.arguments as UserModel;
      nameEC.text.isEmpty ? nameEC.text = employee.name : nameEC.text;
      emailEC.text.isEmpty ? emailEC.text = employee.email : emailEC.text;
      employeeId == 0 ? employeeId = employee.id : employeeId;

      registerOrAlter = false;
    }

    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);
    final companyAsyncValue = ref.watch(getMyCompanyProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          if (registerOrAlter) {
            Messages.showSuccess('Usuario cadastrado com sucesso', context);
          } else {
            Messages.showSuccess('Usuario alterado com sucesso', context);
          }
          Navigator.of(context).pop();
          // ref.invalidate(userRepositoryProvider);
          ref.invalidate(browserEmployeesVmProvider);
          ref.invalidate(employeeRegisterVmProvider);
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar colaborador'),
        ),
        body: companyAsyncValue.when(
          error: (error, stackTrace) {
            log('Erro ao carregar a página',
                error: error, stackTrace: stackTrace);
            return const Center(
              child: Text('Erro ao carregar a pagina'),
            );
          },
          loading: () => const AppLoader(),
          data: (companyModel) {
            final CompanyModel(:openingDays, :openingHours) = companyModel;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(
                          height: 32,
                        ),
                        Offstage(
                          offstage: !registerOrAlter,
                          child: Row(
                            children: [
                              Checkbox.adaptive(
                                  value: registerADM,
                                  onChanged: (value) {
                                    setState(() {
                                      registerADM = !registerADM;
                                      employeeRegisterVM
                                          .setRegisterADM(registerADM);
                                    });
                                  }),
                              const Expanded(
                                child: Text(
                                  "Sou administrador e quero me cadastrar como colaborador",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: registerADM,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: nameEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.required(
                                        'Nome obrigatorio'),
                                onTapOutside: (_) => context.unfocus(),
                                decoration: const InputDecoration(
                                  label: Text("Nome"),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: emailEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(
                                            'E-mail obrigatorio'),
                                        Validatorless.email('E-mail inválido'),
                                      ]),
                                onTapOutside: (_) => context.unfocus(),
                                decoration: const InputDecoration(
                                  label: Text('E-mail'),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                controller: passwordEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(
                                            'Senha obrigatorio'),
                                        Validatorless.min(6,
                                            'Senha deve ter no minimo 6 caracteres'),
                                      ]),
                                onTapOutside: (_) => context.unfocus(),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  label: Text('Senha'),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        WeekdaysPanel(
                          enableDays: openingDays,
                          onDayPressed: employeeRegisterVM.addOrRemoveWorkDays,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        HoursPanel(
                          startTime: 6,
                          endTime: 23,
                          onHourPressed:
                              employeeRegisterVM.addOrRemoveWorkHours,
                          enabledTimes: openingHours,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(56)),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case false || null:
                                  Messages.showError(
                                      'Existem campos inválidos', context);
                                case true:
                                  final EmployeeRegisterState(
                                    workDays: List(isNotEmpty: hasWorkDays),
                                    workHours: List(isNotEmpty: hasWorkHours),
                                  ) = ref.watch(employeeRegisterVmProvider);

                                  if (!hasWorkDays || !hasWorkHours) {
                                    Messages.showError(
                                        'Por favor selecione os dias da semana e horarios de funcionamento',
                                        context);
                                    return;
                                  }
                                  final name = nameEC.text;
                                  final email = emailEC.text;
                                  final password = passwordEC.text;
                                  if (registerOrAlter) {
                            employeeRegisterVM.register(
                                    name: name,
                                    email: email,
                                    password: password,
                                  );
                          } else {
                            employeeRegisterVM.alter(
                              id: employeeId,
                              name: name,
                              email: email,
                              password: password,
                            );
                          }
                              }
                            },
                            child: Text(registerOrAlter ?
                              'Cadastrar Usuario': 'Alterar Usuario',
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
