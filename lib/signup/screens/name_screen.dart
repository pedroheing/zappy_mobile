import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/email_screen.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

class NameScreen extends StatefulWidget {
  final bool isKeyboardVisible;

  const NameScreen({Key? key, required this.isKeyboardVisible})
      : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final form = FormGroup({
    'firstName': FormControl<String>(validators: [Validators.required]),
    'lastName': FormControl<String>(),
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
                    child: const EmailScreen()));
          },
          text: 'Avançar'),
      signupHeader: _buildSignupHeader(),
    ));
  }

  SignupHeader _buildSignupHeader() {
    return SignupHeader(
      title: 'Qual é o seu nome?',
      closeKeyboardOnPop: CloseKeyboardOnPop(isKeyboardVisible: (ctx) {
        return KeyboardVisibilityProvider.isKeyboardVisible(ctx);
      }),
    );
  }

  Column _buildFormBody() {
    return Column(
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
      ],
    );
  }
}
