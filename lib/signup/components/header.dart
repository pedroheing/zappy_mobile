import 'package:flutter/material.dart';

typedef KeyboardVisibleCallback = bool Function(BuildContext context);

class CloseKeyboardOnPop {
  final KeyboardVisibleCallback isKeyboardVisible;
  CloseKeyboardOnPop({required this.isKeyboardVisible});
}

class SignupHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final CloseKeyboardOnPop? closeKeyboardOnPop;

  const SignupHeader(
      {Key? key, required this.title, this.subtitle, this.closeKeyboardOnPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  if (closeKeyboardOnPop != null &&
                      closeKeyboardOnPop!.isKeyboardVisible(context)) {
                    FocusScope.of(context).unfocus();
                    // waits for the keyboard to close
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.of(context).pop();
                    });
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      )),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
