import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
  });

  @override
  Widget build(BuildContext context) {
    return SignupTemplateScreen(
      form: form,
      formBody: _buildFormBody(),
      nextButton: NextButton(onPressed: null, text: 'Avançar'),
      signupHeader: _buildSignupHeader(),
    );
  }

  Column _buildFormBody() {
    return Column(
      children: [],
    );
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Crie uma senha',
      subtitle:
          'A senha deve ter ao menos seis caracteres, incluindo números, letras maiúsculas e letras minúsculas.',
    );
  }
}
