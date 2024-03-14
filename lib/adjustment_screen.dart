import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: AdjustmentScreen()));
}

class AdjustmentScreen extends StatefulWidget {
  @override
  _AdjustmentScreenState createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  File? _pickedImage;
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5; // Initial slider value

  Future<void> _pickImage() async {
    final pickedImageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
        _selectedFilter = null; // Reset selected filter when picking a new image
      });
    }
  }

  void _applyFilter(ColorFilter filter, double value) {
    setState(() {
      _selectedFilter = filter;
      _sliderValue = value;
    });
  }

  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Adjustments'),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.clear)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_task)),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 20),
                if (_pickedImage != null)
                  Column(
                    children: [
                      if (_selectedFilter != null)
                        ColorFiltered(
                          colorFilter: _selectedFilter!,
                          child: Image.file(_pickedImage!), // Display picked image
                        )
                      else
                        Image.file(_pickedImage!), // Display picked image
                      SizedBox(height: 20),
                      Wrap(
                        children: [
                          _buildFilterButton(
                            'Brightness',
                            _generateColorFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Exposure',
                            _generateExposureFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Fade',
                            _generateFadeFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Highlight',
                            _generateHighlightFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Saturation',
                            _generateSaturationFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Shadow',
                            _generateShadowFilter(_sliderValue),
                            _sliderValue,
                          ),
                          _buildFilterButton(
                            'Vignette',
                            _generateVignetteFilter(_sliderValue),
                            _sliderValue,
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
                if (_pickedImage == null)
                  Text('No image selected'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
      String label, ColorFilter filter, double sliderValue) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _applyFilter(filter, sliderValue),
          child: Text(label),
        ),
        Slider(
          value: sliderValue,
          min: 0.0,
          max: 1.0,
          onChanged: (value) => _updateSliderValue(value),
        ),
      ],
    );
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
