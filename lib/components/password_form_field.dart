import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Password {
  bool isIconVisible;
  bool isVisible;

  Password({this.isIconVisible = false, this.isVisible = false});
}

class PasswordNotifier extends StateNotifier<Password> {
  PasswordNotifier() : super(Password());

  void togglePasswordVisibility() {
    state = Password(
        isVisible: !state.isVisible, isIconVisible: state.isIconVisible);
  }

  void onFieldValueChanges(String value) {
    final isIconVisible = value != '';
    final p =
        Password(isIconVisible: isIconVisible, isVisible: state.isVisible);
    if (!isIconVisible) {
      p.isVisible = false;
    }
    state = p;
  }
}

class PasswordFormField extends StatelessWidget {
  final String formControlName;
  final bool autofocus;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final void Function(String value)? onChanged;
  final passwordProvider =
      StateNotifierProvider<PasswordNotifier, Password>((ref) {
    return PasswordNotifier();
  });

  PasswordFormField(
      {Key? key,
      required this.formControlName,
      this.autofocus = false,
      this.validationMessages,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final password = ref.watch(passwordProvider);
      return ReactiveTextField(
        formControlName: formControlName,
        obscureText: !password.isVisible,
        autofocus: autofocus,
        onChanged: (control) {
          if (onChanged != null) {
            onChanged!(control.value as String);
          }
          ref
              .read(passwordProvider.notifier)
              .onFieldValueChanges(control.value as String);
        },
        validationMessages: validationMessages ??
            {
              ValidationMessage.required: (_) =>
                  AppLocalizations.of(context).validationRequired,
            },
        decoration: InputDecoration(
            label: Text(AppLocalizations.of(context).password),
            suffixIcon: password.isIconVisible
                ? IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: password.isVisible
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () {
                      ref
                          .read(passwordProvider.notifier)
                          .togglePasswordVisibility();
                    },
                  )
                : null),
      );
    }));
  }
}
