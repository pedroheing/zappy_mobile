
class ProfilePictureIcon {
  final double position;
  final double size;
  ProfilePictureIcon({required this.position, required this.size});
}

class ProfilePictureSizeConfig {
  final double size;
  final ProfilePictureIcon icon;
  ProfilePictureSizeConfig({required this.size, required this.icon});
}

class ProfilePictureSize {
  static final large = ProfilePictureSizeConfig(size: 200, icon: ProfilePictureIcon(position: -15, size: 30));
}
