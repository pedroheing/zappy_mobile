import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zappy/components/theme_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zappy/login/screens/login_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);
  final fontSizeProfilePage = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              buildThemeButton(),
              Expanded(
                  child: IntroductionScreen(
                showNextButton: false,
                showDoneButton: false,
                dotsDecorator: buildDots(context),
                pages: [
                  buildZappyPresentation(context),
                  buildProfilePage(context)
                ],
              )),
              const SizedBox(height: 20),
              buildStartButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Row buildThemeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [ThemeButton()],
    );
  }

  DotsDecorator buildDots(BuildContext context) {
    return DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        color: Theme.of(context).colorScheme.onSecondary,
        activeColor: Theme.of(context).colorScheme.primary,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)));
  }

  PageViewModel buildZappyPresentation(BuildContext context) {
    return PageViewModel(
        decoration: buildPageDecoration(imageFlex: 1),
        title: 'Zappy',
        bodyWidget: Text(AppLocalizations.of(context).zappyPresentation,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
        image: Center(
          child: Image.asset(
            'assets/zappy-icon.png',
            width: 100,
          ),
        ));
  }

  PageViewModel buildProfilePage(BuildContext context) {
    return PageViewModel(
        decoration: buildPageDecoration(),
        title: 'Pedro',
        bodyWidget: Column(
          children: [
            buildTextProfile(
                context, AppLocalizations.of(context).introductionAuthor),
            const SizedBox(
              height: 20,
            ),
            buildTextProfile(
                context, AppLocalizations.of(context).introductionZappy),
            const SizedBox(
              height: 20,
            ),
            buildRichSocialMediaTextProfile(
                context: context,
                text: AppLocalizations.of(context).moreAboutTheProject,
                socialMediaName: 'Github',
                socialMediaUrl: 'https://github.com/pedroheing'),
            const SizedBox(
              height: 20,
            ),
            buildRichSocialMediaTextProfile(
                context: context,
                text: AppLocalizations.of(context).moreAboutTheAuthor,
                socialMediaName: 'LinkedIn',
                socialMediaUrl:
                    'https://www.linkedin.com/in/pedro-henrique-heing-geronimo-59804b148'),
          ],
        ),
        image: const Center(
          child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/my-profile-picture.png')),
        ));
  }

  PageDecoration buildPageDecoration({int imageFlex = 0}) {
    return PageDecoration(
        contentMargin: const EdgeInsets.all(0),
        imageFlex: imageFlex,
        bodyPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20));
  }

  Text buildTextProfile(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSizeProfilePage),
    );
  }

  Text buildRichSocialMediaTextProfile(
      {required BuildContext context,
      required String text,
      required String socialMediaName,
      required String socialMediaUrl}) {
    final uri = Uri.parse(socialMediaUrl);
    return Text.rich(
        TextSpan(
            text: text,
            style: TextStyle(fontSize: fontSizeProfilePage),
            children: [
              TextSpan(
                  text: ' $socialMediaName',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeProfilePage),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    }),
              const TextSpan(text: '.')
            ]),
        textAlign: TextAlign.center);
  }

  Padding buildStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const StadiumBorder()),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => const LogInScreen()));
                  },
                  child: Text(AppLocalizations.of(context)
                      .introductionStartConversation)))
        ],
      ),
    );
  }
}
