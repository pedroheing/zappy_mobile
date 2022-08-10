import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViwer extends StatelessWidget {
  final ImageProvider imageProvider;
  final String? title;

  const ImageViwer({Key? key, required this.imageProvider, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: title != null ? Text(title!) : null,
      ),
      body: PhotoView(
        minScale:PhotoViewComputedScale.contained,
        imageProvider: imageProvider,
      ),
    );
  }
}
