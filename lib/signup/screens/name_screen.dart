import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/components/profile_picture_button.dart';
import 'package:zappy/signup/screens/email_screen.dart';
import 'package:zappy/signup/screens/signup_tempalte_screen.dart';

final profilePictureProvider =
    StateNotifierProvider<ProfilePictureNotifier, String>((ref) {
  return ProfilePictureNotifier();
});

class ProfilePictureNotifier extends StateNotifier<String> {
  ProfilePictureNotifier() : super('');

  final ImagePicker _picker = ImagePicker();

  getProfilePicture() {
    //_picker.pickImage(source: ImageSource.)
  }
}

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
      formBody: _buildFormBody(context),
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
      subtitle: 'Coloque uma foto de perfil (opcional)',
      closeKeyboardOnPop: CloseKeyboardOnPop(isKeyboardVisible: (ctx) {
        return KeyboardVisibilityProvider.isKeyboardVisible(ctx);
      }),
    );
  }

  Widget _buildFormBody(BuildContext ctx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfilePictureButton(),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
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
            const SizedBox(height: 0),
            ReactiveTextField(
              formControlName: 'lastName',
              decoration:
                  const InputDecoration(label: Text("Sobrenome (opcional)")),
            ),
          ],
        ))
      ],
    );
  }
}