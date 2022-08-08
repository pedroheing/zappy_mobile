import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/password_screen.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

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
    return SignupTemplateScreen(
      form: form,
      formBody: _buildFormBody(),
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

  Column _buildFormBody() {
    return Column(
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
        )
      ],
    );
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Qual é seu e-mail?',
    );
  }
}
