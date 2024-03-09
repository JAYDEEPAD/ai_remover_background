import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

void main() {
  runApp(MaterialApp(
    home: CropImage(),
  ));
}

class CropImage extends StatefulWidget {
  const CropImage({Key? key}) : super(key: key);

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Here, you can navigate to a screen where the user can crop the image
          },
          child: Text("Crop Image"),
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text("Crop Image")),
      ),
      body: Center(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : ElevatedButton(
          onPressed: () {
            setState(() {
              imageUrl =
              "https://4.img-dpreview.com/files/p/TS600x600~sample_galleries/3002635523/4971879462.jpg";
            });
          },
            child: Text("Upload Image"),
        ),
      ),
    );
  }
}
