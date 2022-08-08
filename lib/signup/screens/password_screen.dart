import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/components/password_form_field.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

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
    state = RegExp(r'[A-Z]').hasMatch(value);
  }
}

class HasUppercaseTextNotifier extends StateNotifier<bool> {
  HasUppercaseTextNotifier() : super(false);

  onChanged(String value) {
    state = RegExp(r'[a-z]').hasMatch(value);
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
      nextButton: NextButton(onPressed: () {}, text: 'Avançar'),
      signupHeader: _buildSignupHeader(),
    );
  }

  Widget _buildFormBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: const [
            Expanded(
                child: Text("A senha deve ter ao menos",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            _buildRequirement(hasMinCharactersProvider, '6 caracteres'),
            const SizedBox(
              width: 20,
            ),
            _buildRequirement(hasNumbersProvider, 'números')
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            _buildRequirement(hasLowercaseTextProvider, 'letras minisculas'),
            const SizedBox(
              width: 20,
            ),
            _buildRequirement(hasUppercaseTextProvider, 'letras maisculas')
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: PasswordFormField(
              formControlName: 'password',
              autofocus: true,
              onChanged: (value) {
                ref.read(hasMinCharactersProvider.notifier).onChanged(value);
                ref.read(hasNumbersProvider.notifier).onChanged(value);
                ref.read(hasLowercaseTextProvider.notifier).onChanged(value);
                ref.read(hasUppercaseTextProvider.notifier).onChanged(value);
              },
            ))
          ],
        )
      ],
    );
  }

  Consumer _buildRequirement(
      ProviderListenable<dynamic> provider, String requirement) {
    return Consumer(builder: ((context, ref, child) {
      final hasMinCharacters = ref.watch(provider);
      return Flexible(
          child: Row(
        children: [
          Material(
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: Icon(Icons.check_circle,
                  size: 18,
                  color: hasMinCharacters
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).disabledColor),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(requirement),
          )
        ],
      ));
    }));
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Crie uma senha',
    );
  }
}
