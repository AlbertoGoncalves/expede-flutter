import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/hours_panel.dart';
import 'package:expede/src/core/ui/widgets/weekdays_panel.dart';
import 'package:expede/src/features/auth/register/company/company_register_state.dart';
import 'package:expede/src/features/auth/register/company/company_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class CompanyRegisterPage extends ConsumerStatefulWidget {
  const CompanyRegisterPage({super.key});

  @override
  ConsumerState<CompanyRegisterPage> createState() =>
      _CompanyRegisterPageState();
}

class _CompanyRegisterPageState
    extends ConsumerState<CompanyRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final companyRegisterVm =
        ref.watch(companyRegisterVmProvider.notifier);

    ref.listen(companyRegisterVmProvider, (_, state) {
      switch (state.status) {
        case CompanyRegisterStateStatus.initial:
          break;
        case CompanyRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        case CompanyRegisterStateStatus.error:
          Messages.showError(
              'Desculpe ocorreu um errro ao registrar barbearia', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: nameEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.required('Nome obrigatorio'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatorio'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekdaysPanel(
                  onDayPressed: (value) =>
                      companyRegisterVm.addOrRemoveOpenDay(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) =>
                      companyRegisterVm.addOrRemoveOpenHour(value),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        companyRegisterVm.register(
                          nameEC.text,
                          emailEC.text,
                        );
                    }
                  },
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
