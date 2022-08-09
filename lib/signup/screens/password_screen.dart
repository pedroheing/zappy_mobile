import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/components/password_form_field.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/profile_picture_screen.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';
import 'package:zappy/theme/theme_provider.dart';

class MinCharactersNotifier extends StateNotifier<bool> {
  MinCharactersNotifier() : super(false);

  onChanged(String value) {
    state = value.length >= 6;
  }
}

class HasNumbersNotifier extends StateNotifier<bool> {
  HasNumbersNotifier() : super(false);

  onChanged(String value) {
    state = RegExp('\\d').hasMatch(value);
  }
}

class HasLowercaseTextNotifier extends StateNotifier<bool> {
  HasLowercaseTextNotifier() : super(false);

  onChanged(String value) {
    state = RegExp(r'[a-z]').hasMatch(value);
  }
}

class HasUppercaseTextNotifier extends StateNotifier<bool> {
  HasUppercaseTextNotifier() : super(false);

  onChanged(String value) {
    state = RegExp(r'[A-Z]').hasMatch(value);
  }
}

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final form = FormGroup({
    'password': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
      Validators.pattern(RegExp(r'\d+')),
      // Uppercase
      Validators.pattern(RegExp(r'[A-Z]+')),
      // Lowercase
      Validators.pattern(RegExp(r'[a-z]+'))
    ]),
  });

  final hasMinCharactersProvider =
      StateNotifierProvider<MinCharactersNotifier, bool>((ref) {
    return MinCharactersNotifier();
  });

  final hasNumbersProvider =
      StateNotifierProvider<HasNumbersNotifier, bool>((ref) {
    return HasNumbersNotifier();
  });

  final hasLowercaseTextProvider =
      StateNotifierProvider<HasLowercaseTextNotifier, bool>((ref) {
    return HasLowercaseTextNotifier();
  });

  final hasUppercaseTextProvider =
      StateNotifierProvider<HasUppercaseTextNotifier, bool>((ref) {
    return HasUppercaseTextNotifier();
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SignupTemplateScreen(
      form: form,
      formBody: _buildFormBody(),
      nextButton: NextButton(onPressed: () {
        Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const ProfilePictureScreen()));
      }, text: 'Avançar'),
      signupHeader: _buildSignupHeader(),
    );
  }

  Widget _buildFormBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
                child: PasswordFormField(
              formControlName: 'password',
              autofocus: true,
              showErros: (control) => false,
              onChanged: (value) {
                ref.read(hasMinCharactersProvider.notifier).onChanged(value);
                ref.read(hasNumbersProvider.notifier).onChanged(value);
                ref.read(hasLowercaseTextProvider.notifier).onChanged(value);
                ref.read(hasUppercaseTextProvider.notifier).onChanged(value);
              },
            ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _buildRequirement(hasMinCharactersProvider, '6 caracteres'),
        const SizedBox(
          height: 20,
        ),
        _buildRequirement(hasNumbersProvider, 'números'),
        const SizedBox(
          height: 20,
        ),
        _buildRequirement(hasLowercaseTextProvider, 'letras minisculas'),
        const SizedBox(
          height: 20,
        ),
        _buildRequirement(hasUppercaseTextProvider, 'letras maisculas')
      ],
    );
  }

  Consumer _buildRequirement(
      ProviderListenable<dynamic> provider, String requirement) {
    return Consumer(builder: ((context, ref, child) {
      final hasRequirement = ref.watch(provider);
      ref.watch(themeProvider);
      return Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: hasRequirement
                ? ref.read(themeProvider.notifier).isDarkMode ? Colors.green[800] : Colors.green[600]
                : Theme.of(context).disabledColor,
            child: const Icon(
              Icons.check,
              size: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(requirement),
          )
        ],
      );
    }));
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Crie uma senha',
    );
  }
}
