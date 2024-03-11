import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(home: HueScreen(),));
}

class HueScreen extends StatefulWidget {
  @override
  _HueScreenState createState() => _HueScreenState();
}

class _HueScreenState extends State<HueScreen> {
  double _hueValue = 0.0; // Initial hue value
  File? _imageFile; // Image file to be displayed
  bool _loading = false; // Loading indicator flag

  @override
  void initState() {
    super.initState();
  }

  // Function to load the image from gallery
  void _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _loading = true;
      });
      setState(() {
        _imageFile = File(pickedImage.path);
        _loading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  // Function to update hue value
  void _updateHue(double value) {
    setState(() {
      _hueValue = value;
    });
  }

  // Function to generate the ColorFilter matrix for hue adjustment
  List<double> _generateHueMatrix(double hue) {
    final double _radians = (hue * (pi / 180));
    final double _cosVal = 0.5 * (1 - cos(_radians));
    final double _sinVal = 0.5 * (1 - sin(_radians));

    return [
      (_cosVal + (cos(_radians))) + (_sinVal - (sin(_radians))) + (0.5),
      (_cosVal - (cos(_radians))) + (_sinVal + (sin(_radians))) + (0.5),
      (_cosVal - (cos(_radians))) - (_sinVal + (sin(_radians))) + (0.5),
      0.0,
      0.0,
      (_cosVal + (cos(_radians))) - (_sinVal - (sin(_radians))) + (0.5),
      (_cosVal + (cos(_radians))) + (_sinVal + (sin(_radians))) + (0.5),
      (_cosVal - (cos(_radians))) + (_sinVal - (sin(_radians))) + (0.5),
      0.0,
      0.0,
      (_cosVal - (cos(_radians))) - (_sinVal + (sin(_radians))) + (0.5),
      (_cosVal + (cos(_radians))) - (_sinVal - (sin(_radians))) + (0.5),
      (_cosVal + (cos(_radians))) + (_sinVal + (sin(_radians))) + (0.5),
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ];
  }

  // Function to handle download action
  void _downloadImage() async {
    if (_imageFile != null) {
      try {
        final result = await ImageGallerySaver.saveImage(_imageFile!.readAsBytesSync());
        print('Image saved to gallery: $result');
      } catch (error) {
        print('Failed to save image: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hue Adjustment'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadImage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading
                  ? CircularProgressIndicator()
                  : _imageFile != null
                  ? ColorFiltered(
                colorFilter: ColorFilter.matrix(
                    _generateHueMatrix(_hueValue)),
                child: Image.file(_imageFile!),
              )
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Image'),
              ),
              Slider(
                value: _hueValue,
                min: -180.0,
                max: 180.0,
                onChanged: _updateHue,
              ),
              Text('Hue: ${_hueValue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
