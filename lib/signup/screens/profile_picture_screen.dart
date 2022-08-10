import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/components/profile_picture/profile_picture.dart';
import 'package:zappy/components/profile_picture/profile_picture_size.dart';
import 'package:zappy/signup/components/header.dart';
import 'package:zappy/signup/screens/password_screen.dart';
import 'package:zappy/components/signup_tempalte_screen.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  final form = FormGroup({});

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      form: form,
      formBody: _buildFormBody(context),
      nextButton: NextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const PasswordScreen()));
          },
          text: 'Criar conta'),
      signupHeader: _buildSignupHeader(),
    );
  }

  SignupHeader _buildSignupHeader() {
    return const SignupHeader(
      title: 'Coloque uma foto de perfil',
      subtitle: 'Opcional',
    );
  }

  Widget _buildFormBody(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        ProfilePicture(profilePictureSizeConfig: ProfilePictureSize.large)
        ],
    );
  }
}
