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
        onPressedCamera: _onPressedCamera,
        onPressedGallery: _onPressedGallery,
        onPressedRemove: _onPressedRemove,
      ),
    );
  }

  _onPressedCamera() {
    _getProfilePicture(ImageSource.camera);
  }

  _onPressedGallery() {
    _getProfilePicture(ImageSource.gallery);
  }

  void _getProfilePicture(ImageSource imageSource) async {
    Navigator.of(context).pop();
    final image = await picker.pickImage(source: imageSource);
    if (image != null) {
      CroppedFile? croppedFile = await _cropProfilePicture(image.path);
      if (croppedFile != null) {
        setState(() {
          profilePicturePath = croppedFile.path;
        });
      }
    }
  }

  Future<CroppedFile?> _cropProfilePicture(String sourcePath) {
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
