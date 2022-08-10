import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/components/signup_tempalte_screen.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isKeyboardVisible;

  const ForgotPasswordScreen({Key? key, required this.isKeyboardVisible})
      : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
  });

  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    if (widget.isKeyboardVisible) {
      focusNode.requestFocus();
    } else {
      // prevents visual bug on last screen if keyboard opens too fast
      Future.delayed(const Duration(milliseconds: 100), () {
        focusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
        child: FormTemplateScreen(
      form: form,
      formBody: _buildFormBody(),
      nextButton: NextButton(onPressed: () {}, text: 'Recuperar senha'),
      signupHeader: _buildSignupHeader(),
    ));
  }

  SignupHeader _buildSignupHeader() {
    return SignupHeader(
      title: 'Qual é o seu e-mail?',
      closeKeyboardOnPop: CloseKeyboardOnPop(isKeyboardVisible: (ctx) {
        return KeyboardVisibilityProvider.isKeyboardVisible(ctx);
      }),
    );
  }

  Column _buildFormBody() {
    return Column(
      children: [
        ReactiveTextField(
          formControlName: 'email',
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
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
}
