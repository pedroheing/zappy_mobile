import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/components/password_form_field.dart';
import 'package:zappy/login/components/round_button.dart';
import 'package:zappy/recover_password/screens/forgot_password.dart';
import 'package:zappy/signup/screens/email_screen.dart';
import 'package:zappy/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  _buildForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ReactiveForm _buildForm() {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEmailField(),
          _buildPasswordField(),
          const SizedBox(
            height: 25,
          ),
          _buildSigninButton(),
          const SizedBox(
            height: 10,
          ),
          _buildNewAccountButton(),
          const SizedBox(
            height: 10,
          ),
          _buildForgotPasswordButton()
        ],
      ),
    );
  }

  ReactiveTextField<dynamic> _buildEmailField() {
    return ReactiveTextField(
      formControlName: 'email',
      keyboardType: TextInputType.emailAddress,
      validationMessages: {
        ValidationMessage.required: (_) =>
            AppLocalizations.of(context).validationRequired,
        ValidationMessage.email: (_) =>
            AppLocalizations.of(context).validationEmail
      },
      decoration: const InputDecoration(label: Text("E-mail")),
    );
  }

  PasswordFormField _buildPasswordField() {
    return PasswordFormField(formControlName: 'password');
  }

  ReactiveFormConsumer _buildSigninButton() {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return ElevatedRoundButton(
            onPressed: form.valid ? _submit : null,
            child: Text(AppLocalizations.of(context).login));
      },
    );
  }

  Consumer _buildNewAccountButton() {
    return Consumer(builder: (context, ref, child) {
      final isDark = ref.read(themeProvider.notifier).isDarkMode;
      return ElevatedRoundButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: EmailScreen(
                        isKeyboardVisible:
                            KeyboardVisibilityController().isVisible)));
          },
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).disabledColor),
          child: Text(AppLocalizations.of(context).createNewAccount,
              style: TextStyle(color: isDark ? Colors.white : Colors.black)));
    });
  }

  Center _buildForgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: ForgotPasswordScreen(
                      isKeyboardVisible:
                          KeyboardVisibilityController().isVisible)));
        },
        child: Text(AppLocalizations.of(context).forgotPassword),
      ),
    );
  }

  _submit() {}
}
