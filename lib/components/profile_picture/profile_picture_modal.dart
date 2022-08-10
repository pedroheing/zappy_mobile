import 'package:flutter/material.dart';

class ProfilePictureModal extends StatelessWidget {
  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;
  final VoidCallback onPressedRemove;

  const ProfilePictureModal(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery, required this.onPressedRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Foto do perfil",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                IconButton(onPressed: onPressedRemove, icon: const Icon(Icons.delete))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildSourceButton(
                    icon: Icons.photo_camera,
                    onPressed: onPressedCamera,
                    sourceName: 'Câmera'),
                const SizedBox(
                  width: 20,
                ),
                _buildSourceButton(
                    icon: Icons.photo,
                    onPressed: onPressedGallery,
                    sourceName: 'Galeria'),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Column _buildSourceButton(
      {required IconData icon,
      required String sourceName,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(sourceName)
      ],
    );
  }
}
