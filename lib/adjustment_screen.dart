import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:ai_remover_background/filtter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';

class AdjustmentScreen extends StatefulWidget {
  final File orignalimageFile;

  AdjustmentScreen({Key? key, required this.orignalimageFile}) : super(key: key);

  @override
  _AdjustmentScreenState createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5; // Initial slider value
  String _selectedFilterName = ''; // Initialize with an empty string
  GlobalKey _boundaryKey = GlobalKey();


  void _applyFilter(ColorFilter filter, String filterName) {
    setState(() {
      _selectedFilter = filter;
      _selectedFilterName = filterName;
    });
  }

  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
      if (_selectedFilter != null) {
        switch (_selectedFilterName) {
          case 'Brightness':
            _selectedFilter = _generateColorFilter(value);
            break;
          case 'Exposure':
            _selectedFilter = _generateExposureFilter(value);
            break;
          case 'Fade':
            _selectedFilter = _generateFadeFilter(value);
            break;
          case 'Highlight':
            _selectedFilter = _generateHighlightFilter(value);
            break;
          case 'Saturation':
            _selectedFilter = _generateSaturationFilter(value);
            break;
          case 'Shadow':
            _selectedFilter = _generateShadowFilter(value);
            break;
          case 'Blur':
            _selectedFilter = _generateBlurFilter(value);
            break;
          case 'Vignette':
            _selectedFilter = _generateVignetteFilter(value);
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        title: Text('Image Adjustments'),
        actions: [
          IconButton(
            onPressed: () {
              _saveImageToGallery(context);
            },
            icon: Icon(Icons.download),
          )
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if (_selectedFilter != null)
                      RepaintBoundary(
                        key: _boundaryKey,
                        child: ColorFiltered(
                          colorFilter: _selectedFilter!,
                          child: Center(
                            child: ClipRect(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.55, // Specify the width
                                  height: MediaQuery.of(context).size.height * 0.45, // Specify the height
                                  child: Image.file(
                                    widget.orignalimageFile,
                                    fit: BoxFit.contain, // Adjust the image fit
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Center(
                        child: ClipRect(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.55, // Specify the width
                              height: MediaQuery.of(context).size.height * 0.45, // Specify the height
                              child: Image.file(
                                widget.orignalimageFile,
                                fit: BoxFit.contain, // Adjust the image fit
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    Wrap(
                      children: [
                        _buildFilterButton(
                          'Brightness',
                          _generateColorFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Exposure',
                          _generateExposureFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Fade',
                          _generateFadeFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Highlight',
                          _generateHighlightFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Saturation',
                          _generateSaturationFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Shadow',
                          _generateShadowFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Vignette',
                          _generateVignetteFilter(_sliderValue),
                        ),
                        _buildFilterButton(
                          'Blur',
                          _generateBlurFilter(_sliderValue),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 1.0,
                      onChanged: _updateSliderValue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, ColorFilter filter) {
    final bool isSelected = _selectedFilterName == label;
    final buttonColor = isSelected ? Colors.blue : null;
    final textColor = isSelected ? Colors.white : null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _applyFilter(filter, label),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: textColor,
        ),
        child: Text(label),
      ),
    );
  }

  void _saveImageToGallery(context) async {
    try {
      ui.Image? filteredImage = await _captureFilteredImage();
      if (filteredImage != null) {
        ByteData? byteData = await filteredImage.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        img.Image? image = img.decodeImage(pngBytes);
        if (image != null) {
          Uint8List? jpegBytes = img.encodeJpg(image, quality: 700) as Uint8List?;
          await ImageGallerySaver.saveImage(jpegBytes!);

          User? user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            throw Exception('User not authenticated');
          }

          final DateTime uploadTime = DateTime.now();
          print(uploadTime);
          final storageRef = FirebaseStorage.instance.ref().child('users/${user.uid}/images/${DateTime.now().millisecondsSinceEpoch}.png');
          print(storageRef);
          final uploadTask = storageRef.putData(pngBytes);
          print(uploadTask);
          final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
          print(downloadUrl);
          final String url = await downloadUrl.ref.getDownloadURL();
          print(url);

          await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('images').add({
            'imageUrl': url,
            'uploadTime': uploadTime.toIso8601String(),
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved to gallery')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to convert image')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save image')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      print(e);
    }
  }

  Future<ui.Image?> _captureFilteredImage() async {
    try {
      RenderRepaintBoundary boundary = _boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0); // Capture the image
      return image;
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }




  ColorFilter _generateColorFilter(double brightness) {
    return ColorFilter.matrix([
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      brightness,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateExposureFilter(double exposure) {
    return ColorFilter.matrix([
      exposure,
      0,
      0,
      0,
      0,
      0,
      exposure,
      0,
      0,
      0,
      0,
      0,
      exposure,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateFadeFilter(double fade) {
    return ColorFilter.matrix([
      1.0,
      0,
      0,
      0,
      fade,
      0,
      1.0,
      0,
      0,
      fade,
      0,
      0,
      1.0,
      0,
      fade,
      0,
      0,
      0,
      1.0,
      0,
    ]);
  }

  ColorFilter _generateBlurFilter(double blurValue) {
    return ColorFilter.matrix([
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      blurValue * blurValue.toDouble(), // Adjust the last value to control the blur strength
      0,
    ]);
  }

  ColorFilter _generateHighlightFilter(double highlight) {
    return ColorFilter.matrix([
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1 + highlight,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateSaturationFilter(double saturation) {
    return ColorFilter.matrix([
      0.2126 + 0.7874 * saturation,
      0.7152 - 0.7152 * saturation,
      0.0722 - 0.0722 * saturation,
      0,
      0,
      0.2126 - 0.2126 * saturation,
      0.7152 + 0.2848 * saturation,
      0.0722 - 0.0722 * saturation,
      0,
      0,
      0.2126 - 0.2126 * saturation,
      0.7152 - 0.7152 * saturation,
      0.0722 + 0.9278 * saturation,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateShadowFilter(double shadow) {
    return ColorFilter.matrix([
      1,
      0,
      0,
      0,
      shadow,
      0,
      1,
      0,
      0,
      shadow,
      0,
      0,
      1,
      0,
      shadow,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  ColorFilter _generateVignetteFilter(double vignette) {
    return ColorFilter.matrix([
      vignette,
      0,
      0,
      0,
      0,
      0,
      vignette,
      0,
      0,
      0,
      0,
      0,
      vignette,
      0,
      0,
      0,
      0,
      0,
      1.0 - vignette,
      0,
    ]);
  }

}
