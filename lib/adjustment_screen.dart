import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class AdjustmentScreen extends StatefulWidget {
  final File orignalimageFile;

  AdjustmentScreen({Key? key, required this.orignalimageFile}) : super(key: key);

  @override
  _AdjustmentScreenState createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5; // Initial slider value
  String _selectedFilterName = '';// Initialize with an empty string
   File? _imageFile;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Adjustments'),
        actions: [
          IconButton(
            onPressed: () {
              //_downloadImage();
              _saveImageToGallery();
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
                      ColorFiltered(
                        colorFilter: _selectedFilter!,
                        child: Container(
                          width: 200, // Specify the width
                          height: 200, // Specify the height
                          child: Image.file(
                            widget.orignalimageFile,
                            fit: BoxFit.cover, // Adjust the image fit
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 200, // Specify the width
                        height: 200, // Specify the height
                        child: Image.file(
                          widget.orignalimageFile,
                          fit: BoxFit.cover, // Adjust the image fit
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

  /*void _downloadImage() async {
    if (_imageFile != null) {
      try {
        final appDir = await getExternalStorageDirectory();
        final fileName = 'filtered_image.jpg';
        final filteredImage = File('${appDir!.path}/$fileName');
        await filteredImage.writeAsBytes(_imageFile!.readAsBytesSync());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Filtered image saved to: ${filteredImage.path}')),
        );
      } catch (error) {
        print('Failed to save filtered image: $error');
      }
    }
  }*/

  /*Future<void> _downloadImage() async {
    if (_imageFile != null) {
      try {
        final appDir = await getExternalStorageDirectory();
        final fileName = 'cropped_image.png';
        final destination = File('${appDir!.path}/$fileName');
        await _imageFile!.copy(destination.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved to ${destination.path}'),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save image: $error'),
          ),
        );
      }
    }
  }*/


  void _saveImageToGallery() async {
    try {
      var image = widget.orignalimageFile;
      if (_selectedFilter != null) {
        image = await _applyFilterToImage(image);
      }

      final result = await ImageGallerySaver.saveFile(image.path);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved to gallery')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save image')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      print(e);
    }
  }

  Future<File> _applyFilterToImage(File imageFile) async {
    final image = img.decodeImage(await imageFile.readAsBytes())!;
    final filteredImage = _applyFilterInBackground(image, _selectedFilter!);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/filtered_image.png');
    await tempFile.writeAsBytes(filteredImage);
    return tempFile;
  }

  Uint8List _applyFilterInBackground(img.Image image, ColorFilter filter) {
    final filteredImage = img.copyResize(image, width: image.width, height: image.height);
    final byteData = img.encodePng(filteredImage);
    return Uint8List.fromList(byteData);
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
