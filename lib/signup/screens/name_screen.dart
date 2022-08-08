import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/constants.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/email_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final form = FormGroup({
    'firstName': FormControl<String>(validators: [Validators.required]),
    'lastName': FormControl<String>(),
  });
  final focusNode = FocusNode();

  _NameScreenState() {
    // prevents visual bug on last screen if keyboard opens too fast
    Future.delayed(const Duration(milliseconds: 100), () {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SignupHeader(
                    title: 'Qual é o seu nome?',
                    closeKeyboardOnPop:
                        CloseKeyboardOnPop(isKeyboardVisible: (ctx) {
                      return KeyboardVisibilityProvider.isKeyboardVisible(
                          ctx);
                    }),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: _buildForm(context)),
                ],
              )),
        ),
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
            formControlName: 'firstName',
            focusNode: focusNode,
            validationMessages: {
              ValidationMessage.required: (_) =>
                  AppLocalizations.of(context).validationRequired,
            },
            decoration: const InputDecoration(label: Text("Nome")),
          ),
          const SizedBox(height: 10),
          ReactiveTextField(
            formControlName: 'lastName',
            decoration:
                const InputDecoration(label: Text("Sobrenome (Opcional)")),
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
                              child: const EmailScreen()));
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: roundedRectangleBorder),
              child: const Text("Avançar"),
            );
          })
        ],
      ),
    );
  }
}
