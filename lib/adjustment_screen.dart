import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:ai_remover_background/filtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdjustmentScreen extends StatefulWidget {
  final File orignalimageFile;
  final File imageFile;
  final ui.Image? filteredImage;

  AdjustmentScreen({
    Key? key,
    required this.orignalimageFile,
    required this.imageFile,
    this.filteredImage,
  }) : super(key: key);

  @override
  _AdjustmentScreenState createState() => _AdjustmentScreenState();
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  ColorFilter? _selectedFilter;
  double _sliderValue = 0.5;
  String _selectedFilterName = '';
  GlobalKey _boundaryKey = GlobalKey();
  ui.Image? _filteredImage;

  @override
  void initState() {
    super.initState();
    _filteredImage = widget.filteredImage;
  }

  List<Map<String, dynamic>> iconDataList = [
    {"icon": Icons.auto_fix_high, "filterName": 'Auto'},
    {"icon": Icons.highlight, "filterName": 'Highlight'},
    {"icon": Icons.brightness_medium, "filterName": 'Brightness'},
    {"icon": Icons.exposure, "filterName": 'Exposure'},
    {"icon": Icons.blur_circular, "filterName": 'Blur'},
    {"icon": Icons.face, "filterName": 'Fade'},
    {"icon": Icons.colorize, "filterName": 'Saturation'},
    {"icon": Icons.shutter_speed, "filterName": 'Shadow'},
    {"icon": Icons.vignette, "filterName": 'Vignette'},
  ];

  bool _isIconButtonSelected = false;

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

  void _navigateToFilterPage(
      BuildContext context, ui.Image? filteredImage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(
          imageFile: widget.orignalimageFile,
          filteredImage: _filteredImage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Adjustments'),
        actions: [
          IconButton(
            onPressed: () {
              //_saveImageToGallery(context);
              _navigateToFilterPage(context, _filteredImage);
            },
            icon: Icon(Icons.check, color: Colors.black),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.file(
                                widget.orignalimageFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.file(widget.orignalimageFile,
                              fit: BoxFit.cover),
                        ),
                      ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: iconDataList.map((iconData) {
                          return _buildIconButton(
                              iconData['icon'], iconData['filterName']);
                        }).toList(),
                      ),
                    ),
                    if (_isIconButtonSelected)
                      Column(
                        children: [
                          Slider(
                            value: _sliderValue,
                            min: -100,
                            max: 100,
                            onChanged: _updateSliderValue,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Slider Value: ${_sliderValue.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  Widget _buildIconButton(IconData icon, String filterName) {
    final bool isSelected = _selectedFilterName == filterName;
    var buttonColor = isSelected ? Colors.deepPurple[200] : null; // Default color
    final textColor = isSelected ? Colors.white : null;

    // Check if the filter is applied
    if (_selectedFilterName != null && _selectedFilterName == filterName) {
      buttonColor = Colors.green; // Change button color for applied filters
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor ?? Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  if (filterName == 'Auto') {
                    _applyAllFilters(_sliderValue);
                    setState(() {
                      _isIconButtonSelected = true; // Show slider
                    });
                  } else {
                    _applyFilterByName(filterName);
                    setState(() {
                      _isIconButtonSelected = true; // Show slider
                    });
                  }
                },
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            filterName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }

  void _applyFilterByName(String filterName) {
    setState(() {
      _selectedFilterName = filterName;
      switch (filterName) {
        case 'Highlight':
          _selectedFilter = _generateHighlightFilter(_sliderValue);
          break;
        case 'Brightness':
          _selectedFilter = _generateColorFilter(_sliderValue);
          break;
        case 'Exposure':
          _selectedFilter = _generateExposureFilter(_sliderValue);
          break;
        case 'Blur':
          _selectedFilter = _generateBlurFilter(_sliderValue);
          break;
        case 'Fade':
          _selectedFilter = _generateFadeFilter(_sliderValue);
          break;
        case 'Saturation':
          _selectedFilter = _generateSaturationFilter(_sliderValue);
          break;
        case 'Shadow':
          _selectedFilter = _generateShadowFilter(_sliderValue);
          break;
        case 'Vignette':
          _selectedFilter = _generateVignetteFilter(_sliderValue);
          break;
        default:
          break;
      }

      _captureFilteredImage().then((image) {
        setState(() {
          _filteredImage = image;
        });
      });
    });
  }

  void _applyAllFilters(double value) {
    List<String> appliedFilters = [];

    for (var iconData in iconDataList) {
      String filterName = iconData['filterName'];
      switch (filterName) {
        case 'Auto':
          break;
        case 'Highlight':
          _selectedFilter = _generateHighlightFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Brightness':
          _selectedFilter = _generateColorFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Exposure':
          _selectedFilter = _generateExposureFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Blur':
          _selectedFilter = _generateBlurFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Fade':
          _selectedFilter = _generateFadeFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Saturation':
          _selectedFilter = _generateSaturationFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Shadow':
          _selectedFilter = _generateShadowFilter(value);
          appliedFilters.add(filterName);
          break;
        case 'Vignette':
          _selectedFilter = _generateVignetteFilter(value);
          appliedFilters.add(filterName);
          break;
        default:
          break;
      }

      _applyFilterByName(filterName);
    }
    print('Applied filters: $appliedFilters');
  }

  Future<ui.Image?> _captureFilteredImage() async {
    try {
      RenderRepaintBoundary boundary =
      _boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final targetWidth = 700;
      final targetHeight = 700;
      final pixelRatio =
      (targetWidth / boundary.size.width).clamp(1.0, double.infinity);

      ui.Image? image = await boundary.toImage(pixelRatio: pixelRatio);

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
      blurValue * blurValue.toDouble(),
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
