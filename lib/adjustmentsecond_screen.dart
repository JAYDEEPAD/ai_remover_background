
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as img;

class AdjustmentSecondScreen extends StatefulWidget {
  final File originalImageFile;

  AdjustmentSecondScreen({Key? key, required this.originalImageFile}) : super(key: key);

  @override
  _AdjustmentSecondScreenState createState() => _AdjustmentSecondScreenState();
}

class _AdjustmentSecondScreenState extends State<AdjustmentSecondScreen> {
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5;
  String _selectedFilterName = '';

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
                      ColorFiltered(
                        colorFilter: _selectedFilter!,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Image.file(
                            widget.originalImageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.file(
                          widget.originalImageFile,
                          fit: BoxFit.cover,
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

  void _saveImageToGallery(BuildContext context) async {
    try {
      var imageToSave = widget.originalImageFile;

      // Apply the selected filter to the image to be saved
      if (_selectedFilter != null) {
        imageToSave = await _applyFilterToImage(imageToSave, _selectedFilter!);
      }

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveFile(imageToSave.path);
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

  Future<File> _applyFilterToImage(File imageFile, ColorFilter filter) async {
    final image = img.decodeImage(await imageFile.readAsBytes())!;
    final filteredImage = _applyFilterInBackground(image, filter);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/filtered_image.png');
    await tempFile.writeAsBytes(img.encodePng(filteredImage));
    return tempFile;
  }

  img.Image _applyFilterInBackground(img.Image image, ColorFilter filter) {
    final filteredImage = img.copyResize(image, width: image.width, height: image.height);
    return filteredImage;
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
        1,
        0,
        fade,
        0,
        1,
    0,
    fade,
    0,
    0,
    1,
    0,
    fade,
    0,
    0,
    1,
    0,
    fade,
    0,
    0,
    1,
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

