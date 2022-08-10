import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/password_screen.dart';
import 'package:zappy/components/signup_tempalte_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      form: form,
      formBody: _buildFormBody(context),
      nextButton: NextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const PasswordScreen()));
          },
          text: 'Avançar'),
      signupHeader: _buildSignupHeader(),
    );
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Qual é o seu nome?'
    );
  }

  Widget _buildFormBody(BuildContext ctx) {
    return Column(
      children: [
        ReactiveTextField(
          formControlName: 'firstName',
          autofocus: true,
          validationMessages: {
            ValidationMessage.required: (_) =>
                AppLocalizations.of(context).validationRequired,
          },
          decoration: const InputDecoration(label: Text("Nome")),
        ),
        const SizedBox(height: 0),
        ReactiveTextField(
          formControlName: 'lastName',
          decoration:
              const InputDecoration(label: Text("Sobrenome (opcional)")),
        ),
      ],
    );
  }
}
