import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zappy/components/image_viwer.dart';
import 'package:zappy/components/profile_picture/profile_picture_modal.dart';
import 'package:zappy/components/profile_picture/profile_picture_size.dart';

const defaultImage = "assets/profile-placeholder.jpg";

class ProfilePicture extends StatefulWidget {
  final ProfilePictureSizeConfig profilePictureSizeConfig;

  const ProfilePicture({Key? key, required this.profilePictureSizeConfig})
      : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String? profilePicturePath;
  final ImagePicker picker = ImagePicker();
  final ImageCropper cropper = ImageCropper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.profilePictureSizeConfig.size,
      width: widget.profilePictureSizeConfig.size,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ImageViwer(
                          imageProvider: getImageProvider(),
                          title: "Foto do perfil",
                        )));
              },
              child: CircleAvatar(
                backgroundImage: getImageProvider(),
              )),
          Positioned(
              bottom: 0,
              right: widget.profilePictureSizeConfig.icon.position,
              child: RawMaterialButton(
                onPressed: _onPressed,
                elevation: 2.0,
                fillColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                child: Icon(
                  Icons.camera_alt,
                  size: widget.profilePictureSizeConfig.icon.size,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )),
        ],
      ),
    );
  }

  ImageProvider<Object> getImageProvider() => profilePicturePath != null
      ? Image.file(File(profilePicturePath!)).image
      : const AssetImage(defaultImage);

  _onPressed() {
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

  _onPressedCamera() async {
    // await Permission.camera.request();
    _getProfilePicture(ImageSource.camera);
  }

  _onPressedGallery() {
    _getProfilePicture(ImageSource.gallery);
  }

  void _getProfilePicture(ImageSource imageSource) async {
    Navigator.of(context).pop();
    picker.pickImage(source: imageSource).then((image) async {
      if (image != null) {
        CroppedFile? croppedFile = await _cropProfilePicture(image.path);
        if (croppedFile != null) {
          setState(() {
            profilePicturePath = croppedFile.path;
          });
        }
      }
    }).catchError((e) => print(e));
  }

  Future<CroppedFile?> _cropProfilePicture(String sourcePath) {
    return cropper.cropImage(
      sourcePath: sourcePath,
      cropStyle: CropStyle.circle,
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
