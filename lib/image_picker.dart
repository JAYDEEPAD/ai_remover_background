import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePicker1{
  final ImageSource source;

  ImagePicker1({required this.source});

  pick({required Function(File?) onPick}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      onPick(File(image.path));
    } else {
      onPick(null);
    }
  }
}
