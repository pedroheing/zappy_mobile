import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zappy/signup/components/profile_picture_modal.dart';

class ProfilePictureButton extends StatefulWidget {
  const ProfilePictureButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePictureButton> createState() => _ProfilePictureButtonState();
}

class _ProfilePictureButtonState extends State<ProfilePictureButton> {
  String? profilePicturePath;
  final ImagePicker picker = ImagePicker();
  final ImageCropper cropper = ImageCropper();

  @override
  Widget build(BuildContext context) {
    return profilePicturePath != null
        ? InkWell(
            onTap: () => _onPressed(context),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: FileImage(File(profilePicturePath!)),
            ))
        : ElevatedButton(
            onPressed: () => _onPressed(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.photo_camera),
          );
  }

  _onPressed(BuildContext context) {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfilePictureModal(
        onPressedCamera: () => _onPressedCamera(context),
        onPressedGallery: () => _onPressedGallery(context),
        onPressedRemove: _onPressedRemove,
      ),
    );
  }

  _onPressedCamera(BuildContext context) {
    _getProfilePicture(context, ImageSource.camera);
  }

  _onPressedGallery(BuildContext context) {
    _getProfilePicture(context, ImageSource.gallery);
  }

  void _getProfilePicture(BuildContext context, ImageSource imageSource) {
    picker.pickImage(source: imageSource).then((value) async {
      if (value == null) return;
      CroppedFile? croppedFile = await _cropProfilePicture(value.path, context);
      if (croppedFile != null) {
        setState(() {
          Navigator.of(context).pop();
          profilePicturePath = croppedFile.path;
        });
      }
    });
  }

  Future<CroppedFile?> _cropProfilePicture(
      String sourcePath, BuildContext context) {
    return cropper.cropImage(
      sourcePath: sourcePath,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Foto do perfil',
            activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
            toolbarColor: Theme.of(context).colorScheme.secondary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onSecondary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Foto do perfil',
        ),
      ],
    );
  }

  _onPressedRemove() {
    Navigator.of(context).pop();
    setState(() {
      profilePicturePath = null;
    });
  }
}
