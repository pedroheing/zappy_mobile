import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/name_screen.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

class EmailScreen extends StatefulWidget {
  final bool isKeyboardVisible;

  const EmailScreen({Key? key, required this.isKeyboardVisible})
      : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
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
      child: SignupTemplateScreen(
        form: form,
        formBody: _buildFormBody(),
        nextButton: NextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const NameScreen()));
            },
            text: 'Avançar'),
        signupHeader: _buildSignupHeader(),
      ),
    );
  }

  Column _buildFormBody() {
    return Column(
      children: [
        ReactiveTextField(
          formControlName: 'email',
          focusNode: focusNode,
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
    return SignupHeader(
      title: 'Qual é seu e-mail?',
      closeKeyboardOnPop: CloseKeyboardOnPop(isKeyboardVisible: (ctx) {
        return KeyboardVisibilityProvider.isKeyboardVisible(ctx);
      }),
    );
  }
}
