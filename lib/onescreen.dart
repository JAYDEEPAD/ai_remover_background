/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Cropper',
      home: CropImageScreen(),
    );
  }
}

class CropImageScreen extends StatefulWidget {
  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  File? _imageFile;
  File? _filteredImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Image')),
      body: Center(
        child: _filteredImageFile != null
            ? Image.file(_filteredImageFile!)
            : (_imageFile != null ? Image.file(_imageFile!) : Text('No Image Selected')),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getImage,
            tooltip: 'Select Image',
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _cropImage(_imageFile);
            },
            tooltip: 'Crop',
            child: Icon(Icons.crop),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              if (_imageFile != null) {
                _navigateToAdjustImageScreen();
              }
            },
            tooltip: 'Adjust',
            child: Icon(Icons.adjust),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _filteredImageFile = null;
      });
    }
  }

  Future<void> _cropImage(File? imageFile) async {
    if (imageFile == null) {
      print('Image file is null');
      return;
    }

    try {
      File? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop',
          aspectRatioLockEnabled: false,
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: false,
        ),
      );
      if (cropped != null) {
        setState(() {
          _imageFile = cropped;
          _filteredImageFile = null;
        });
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }

  void _navigateToAdjustImageScreen() async {
    final filteredImageFile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdjustImageScreen(imageFile: _imageFile!),
      ),
    );
    if (filteredImageFile != null) {
      setState(() {
        _filteredImageFile = filteredImageFile;
      });
    }
  }
}

class AdjustImageScreen extends StatefulWidget {
  final File imageFile;

  AdjustImageScreen({required this.imageFile});

  @override
  _AdjustImageScreenState createState() => _AdjustImageScreenState();
}

class _AdjustImageScreenState extends State<AdjustImageScreen> {
  double _brightnessValue = 0.0;
  double _contrastValue = 1.0;
  bool _showBrightnessSlider = false;
  bool _showContrastSlider = false;

  void _applyBrightnessAndContrast() {
    setState(() {
      _brightnessValue = (_brightnessValue - 0.5) * 2.0;
      _contrastValue = _contrastValue.clamp(0.0, 2.0);
    });
  }

  List<int> _filteredImageData() {
    List<int> imageData = widget.imageFile.readAsBytesSync();
    img.Image image = img.decodeImage(Uint8List.fromList(imageData))!;
    img.adjustColor(image, brightness: _brightnessValue, contrast: _contrastValue);
    List<int> adjustedImageData = img.encodePng(image)!;
    return adjustedImageData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adjust Image'),
        actions: [
          IconButton(
            onPressed: () {
              _applyBrightnessAndContrast();
              Navigator.pop(context, _filteredImageData());
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(
                <double>[
                  _contrastValue, 0, 0, 0, _brightnessValue,
                  0, _contrastValue, 0, 0, _brightnessValue,
                  0, 0, _contrastValue, 0, _brightnessValue,
                  0, 0, 0, 1, 0,
                ],
              ),
              child: Hero(
                tag: 'image_hero_${widget.imageFile.path}', // Unique tag for the Hero widget
                child: Image.file(widget.imageFile),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (_showBrightnessSlider)
                  Column(
                    children: [
                      Text('Brightness'),
                      Slider(
                        value: _brightnessValue,
                        min: -1.0,
                        max: 1.0,
                        onChanged: (value) {
                          setState(() {
                            _brightnessValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showBrightnessSlider = !_showBrightnessSlider;
                    });
                  },
                  child: Text(_showBrightnessSlider ? 'Hide Brightness Slider' : 'Show Brightness Slider'),
                ),
                SizedBox(height: 10),
                if (_showContrastSlider)
                  Column(
                    children: [
                      Text('Contrast'),
                      Slider(
                        value: _contrastValue,
                        min: 0.0,
                        max: 2.0,
                        onChanged: (value) {
                          setState(() {
                            _contrastValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showContrastSlider = !_showContrastSlider;
                    });
                  },
                  child: Text(_showContrastSlider ? 'Hide Contrast Slider' : 'Show Contrast Slider'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
