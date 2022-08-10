import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:zappy/constants.dart';
import 'package:zappy/signup/components/header.dart';

class NextButton {
  VoidCallback? onPressed;
  String text;

  NextButton({required this.onPressed, required this.text});
}

class FormTemplateScreen extends StatelessWidget {
  final SignupHeader signupHeader;
  final FormGroup form;
  final Widget formBody;
  final NextButton nextButton;

  const FormTemplateScreen(
      {Key? key,
      required this.signupHeader,
      required this.form,
      required this.formBody,
      required this.nextButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                signupHeader,
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _buildForm(context),
                )),
              ],
            )),
      ),
    );
  }

  ReactiveForm _buildForm(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: formBody,
          )),
          ReactiveFormConsumer(builder: (context, formGroup, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: formGroup.valid ? nextButton.onPressed : null,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: roundedRectangleBorder),
                child: Text(nextButton.text),
              ),
            );
          })
        ],
      ),
    );
  }
}
