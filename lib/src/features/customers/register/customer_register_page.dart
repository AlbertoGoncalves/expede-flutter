import 'package:expede/src/core/ui/helpers/form_helper.dart';
import 'package:expede/src/core/ui/helpers/messages.dart';
import 'package:expede/src/core/ui/widgets/avatar_widget.dart';
import 'package:expede/src/features/customers/browser_customers/browser_customers_vm.dart';
import 'package:expede/src/features/customers/register/customer_register_state.dart';
import 'package:expede/src/features/customers/register/customer_register_vm.dart';
import 'package:expede/src/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class CustomerRegisterPage extends ConsumerStatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  ConsumerState<CustomerRegisterPage> createState() =>
      _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends ConsumerState<CustomerRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final addressEC = TextEditingController();
  var registerOrAlter = true;
  int customerId = 0;

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    addressEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final customer =
          ModalRoute.of(context)!.settings.arguments as CustomerModel;
      nameEC.text.isEmpty ? nameEC.text = customer.name : nameEC.text;
      emailEC.text.isEmpty ? emailEC.text = customer.email : emailEC.text;
      addressEC.text.isEmpty
          ? addressEC.text = customer.address
          : addressEC.text;
      customerId == 0 ? customerId = customer.id : customerId;

      registerOrAlter = false;
    }

    final customerRegisterVM = ref.watch(customerRegisterVmProvider.notifier);

    ref.listen(customerRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case CustomerRegisterStateStatus.initial:
          break;
        case CustomerRegisterStateStatus.success:
          if (registerOrAlter) {
            Messages.showSuccess('Cliente cadastrado com sucesso', context);
          } else {
            Messages.showSuccess('Cliente alterado com sucesso', context);
          }
          Navigator.of(context).pop();
          ref.invalidate(customerRegisterVmProvider);
          ref.invalidate(browserCustomersVmProvider);
        case CustomerRegisterStateStatus.error:
          Messages.showError('Erro ao registrar Cliente', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cliente'),
      ),
      body: SingleChildScrollView(
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
                  Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: nameEC,
                        validator: Validatorless.required('Nome obrigatorio'),
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
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatorio'),
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
                        controller: addressEC,
                        validator:
                            Validatorless.required('Endereço obrigatorio'),
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          label: Text('Endereço'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
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
                          final name = nameEC.text;
                          final email = emailEC.text;
                          final address = addressEC.text;
                          if (registerOrAlter) {
                            customerRegisterVM.register(
                              name: name,
                              email: email,
                              address: address,
                            );
                          } else {
                            customerRegisterVM.alter(
                              id: customerId,
                              name: name,
                              email: email,
                              address: address,
                            );
                          }
                      }
                    },
                    child: Text(
                      registerOrAlter ? 'Cadastrar Cliente' : 'Alterar Cliente',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
