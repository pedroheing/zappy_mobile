import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LogInScreen extends StatelessWidget {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  'assets/zappy-icon.png',
                  width: 100,
                ),
              ),
              const Spacer(),
              ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'email',
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'Este campo é obrigatório',
                        ValidationMessage.email: (_) => 'E-mail inválido'
                      },
                      decoration: const InputDecoration(label: Text("E-mail")),
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'Este campo é obrigatório',
                      },
                      decoration: const InputDecoration(label: Text("Senha")),
                    ),
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return ElevatedButton(
                            onPressed: form.valid ? _submit : null,
                            child: Text("Submit"));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    print('Hello Reactive Forms!!!');
  }
}
