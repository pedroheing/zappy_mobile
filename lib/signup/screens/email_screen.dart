import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/constants.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/password_screen.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SignupHeader(
                  title: 'Qual é seu e-mail?',
                ),
                const SizedBox(height: 20),
                Expanded(child: _buildForm(context)),
              ],
            )),
      ),
    );
  }

  ReactiveForm _buildForm(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReactiveTextField(
            formControlName: 'email',
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            validationMessages: {
              ValidationMessage.required: (_) =>
                  AppLocalizations.of(context).validationRequired,
              ValidationMessage.email: (_) =>
                  AppLocalizations.of(context).validationEmail,
            },
            decoration: const InputDecoration(label: Text("E-mail")),
          ),
          const Spacer(),
          ReactiveFormConsumer(builder: (context, formGroup, child) {
            return ElevatedButton(
              onPressed: formGroup.valid
                  ? () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const PasswordScreen()));
                    }
                  : null,
              style: ElevatedButton.styleFrom(shape: roundedRectangleBorder),
              child: const Text("Avançar"),
            );
          })
        ],
      ),
    );
  }
}
