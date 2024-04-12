import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Filters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageFilterPage(),
    );
  }
}

class ImageFilterPage extends StatefulWidget {
  @override
  _ImageFilterPageState createState() => _ImageFilterPageState();
}

class _ImageFilterPageState extends State<ImageFilterPage> {
  File? _imageFile;
  img.Image? _filteredImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;

    setState(() {
      _imageFile = File(pickedImage.path);
      _filteredImage = null; // Reset filtered image
    });
  }

  Widget _buildImage() {
    if (_imageFile == null) {
      return Text('No image selected.');
    } else if (_filteredImage == null) {
      return Image.file(_imageFile!);
    } else {
      return Image.memory(Uint8List.fromList(img.encodePng(_filteredImage!)));
    }
  }

  void _applyFilter(FilterType filterType) {
    if (_imageFile == null) return;

    final image = img.decodeImage(_imageFile!.readAsBytesSync());
    if (image == null) return;

    setState(() {
      _filteredImage = _applyFilterType(image, filterType);
    });
  }

  img.Image _applyFilterType(img.Image image, FilterType filterType) {
    switch (filterType) {
      case FilterType.vivid:
        return _applyVividFilter(image);
      case FilterType.vividWarm:
        return _applyVividWarmFilter(image);
      case FilterType.vividCool:
        return _applyVividCoolFilter(image);
      case FilterType.dramatic:
        return _applyDramaticFilter(image);
      case FilterType.dramaticWarm:
        return _applyDramaticWarmFilter(image);
      case FilterType.dramaticCool:
        return _applyDramaticCoolFilter(image);
      case FilterType.mono:
        return _applyMonoFilter(image);
      case FilterType.silvertone:
        return _applySilvertoneFilter(image);
      case FilterType.noir:
        return _applyNoirFilter(image);
    }
  }

  img.Image _applyVividFilter(img.Image image) {
    final double saturationFactor = 1.5;
    final double brightnessFactor = 1.2;

    img.adjustColor(image, saturation: saturationFactor);
    img.adjustColor(image, brightness: brightnessFactor);


    // Implement vivid filter logic
    return image;
  }

  img.Image _applyVividWarmFilter(img.Image image) {
    final double redFactor = 1.2;
    final double blueFactor = 0.8;

    /*for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final r = (img.getRed(pixel)! * redFactor).clamp(0, 255).toInt();
        final g = img.getGreen(pixel)!;
        final b = (img.getBlue(pixel)! * blueFactor).clamp(0, 255).toInt();

        image.setPixel(x, y, img.Color(r, g, b));
      }
    }
*/
    // Implement vivid warm filter logic
    return image;
  }

  img.Image _applyVividCoolFilter(img.Image image) {
    final double redFactor = 1.2;
    final double blueFactor = 0.8;

    /*for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);

        final r = (img.getRed(pixel)! * redFactor).clamp(0, 255).toInt();
        final g = img.getGreen(pixel)!;
        final b = (img.getBlue(pixel)! * blueFactor).clamp(0, 255).toInt();

        // Set the adjusted pixel values
        image.setPixel(x, y, img.Color(r, g, b));
      }
    }
*/
    // Implement vivid cool filter logic
    return image;
  }

  img.Image _applyDramaticFilter(img.Image image) {
    final double contrastFactor = 1.5;

    img.adjustColor(image, contrast: contrastFactor);


    // Implement dramatic filter logic
    return image;
  }

  img.Image _applyDramaticWarmFilter(img.Image image) {
    final double redFactor = 1.5;

    /*for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final r = (img.getRed(pixel)! * redFactor).clamp(0, 255).toInt();
        final g = img.getGreen(pixel)!;
        final b = img.getBlue(pixel)!;

        image.setPixel(x, y, img.Color(r, g, b));
      }
    }
*/

    // Implement dramatic warm filter logic
    return image;
  }

  img.Image _applyDramaticCoolFilter(img.Image image) {
    final double blueFactor = 1.5;

    /*for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final r = img.getRed(pixel)!;
        final g = img.getGreen(pixel)!;
        final b = (img.getBlue(pixel)! * blueFactor).clamp(0, 255).toInt();

        image.setPixel(x, y, img.Color(r, g, b));
      }
    }
*/

    // Implement dramatic cool filter logic
    return image;
  }

  img.Image _applyMonoFilter(img.Image image) {

    img.grayscale(image);
    // Implement mono filter logic
    return image;
  }

  img.Image _applySilvertoneFilter(img.Image image) {
    final double contrastFactor = 1.2;

    img.adjustColor(image, contrast: contrastFactor);
    img.grayscale(image);


    // Implement silvertone filter logic
    return image;
  }

  img.Image _applyNoirFilter(img.Image image) {
    img.grayscale(image);

    final double contrastFactor = 1.5;

    img.adjustColor(image, contrast: contrastFactor);

    // Implement noir filter logic
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Filters'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildImage(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Select Image'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterButton(
                    text: 'Vivid',
                    onPressed: () => _applyFilter(FilterType.vivid),
                  ),
                  FilterButton(
                    text: 'Vivid Warm',
                    onPressed: () => _applyFilter(FilterType.vividWarm),
                  ),
                  FilterButton(
                    text: 'Vivid Cool',
                    onPressed: () => _applyFilter(FilterType.vividCool),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterButton(
                    text: 'Dramatic',
                    onPressed: () => _applyFilter(FilterType.dramatic),
                  ),
                  FilterButton(
                    text: 'Dramatic Warm',
                    onPressed: () => _applyFilter(FilterType.dramaticWarm),
                  ),
                  FilterButton(
                    text: 'Dramatic Cool',
                    onPressed: () => _applyFilter(FilterType.dramaticCool),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterButton(
                    text: 'Mono',
                    onPressed: () => _applyFilter(FilterType.mono),
                  ),
                  FilterButton(
                    text: 'Silvertone',
                    onPressed: () => _applyFilter(FilterType.silvertone),
                  ),
                  FilterButton(
                    text: 'Noir',
                    onPressed: () => _applyFilter(FilterType.noir),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum FilterType {
  vivid,
  vividWarm,
  vividCool,
  dramatic,
  dramaticWarm,
  dramaticCool,
  mono,
  silvertone,
  noir,
}

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FilterButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
