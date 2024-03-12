import 'dart:math';
import 'dart:ui';

class AdjustmentHelper{
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
  List<double> _generateContrastMatrix(double contrast) {
    return [
      contrast, 0, 0, 0, 0,
      0, contrast, 0, 0, 0,
      0, 0, contrast, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
  ColorFilter _generateExposureFilter(double exposure) {
    return ColorFilter.matrix([
      exposure, 0, 0, 0, 0,
      0, exposure, 0, 0, 0,
      0, 0, exposure, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }
  ColorFilter _generateFadeFilter(double fade) {
    return ColorFilter.matrix([
      1.0, 0, 0, 0, fade,
      0, 1.0, 0, 0, fade,
      0, 0, 1.0, 0, fade,
      0, 0, 0, 1.0, 0,
    ]);
  }
  ColorFilter _generateHighlightFilter(double highlight) {
    return ColorFilter.matrix([
      1 + highlight, 0, 0, 0, 0,
      0, 1 + highlight, 0, 0, 0,
      0, 0, 1 + highlight, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }
  ColorFilter _generateSaturationFilter(double saturation) {
    return ColorFilter.matrix([
      0.2126 + 0.7874 * saturation, 0.7152 - 0.7152 * saturation,
      0.0722 - 0.0722 * saturation, 0, 0,
      0.2126 - 0.2126 * saturation, 0.7152 + 0.2848 * saturation,
      0.0722 - 0.0722 * saturation, 0, 0,
      0.2126 - 0.2126 * saturation, 0.7152 - 0.7152 * saturation,
      0.0722 + 0.9278 * saturation, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }
  ColorFilter _generateShadowFilter(double shadow) {
    return ColorFilter.matrix([
      1, 0, 0, 0, shadow,
      0, 1, 0, 0, shadow,
      0, 0, 1, 0, shadow,
      0, 0, 0, 1, 0,
    ]);
  }
  List<double> _generateVibrancyMatrix(double vibrancy) {
    return [
      1 + 0.4 * vibrancy, 0, 0, 0, 0,
      0, 1 + 0.4 * vibrancy, 0, 0, 0,
      0, 0, 1 + 0.4 * vibrancy, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
  ColorFilter _generateVignetteFilter(double vignette) {
    return ColorFilter.matrix([
      vignette, 0, 0, 0, 0,
      0, vignette, 0, 0, 0,
      0, 0, vignette, 0, 0,
      0, 0, 0, 1.0 - vignette, 0,
    ]);
  }


}