import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: EffectHorizontalWidget(),
    ),
  ));
}

class EffectHorizontalWidget extends StatefulWidget {
  @override
  State<EffectHorizontalWidget> createState() => _EffectHorizontalWidgetState();
}

class _EffectHorizontalWidgetState extends State<EffectHorizontalWidget> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 24),
    child: BeforeAfter(
      thumbColor: Colors.red,
      overlayColor: Colors.white24,
      imageCornerRadius: 40,
      thumbRadius: 24,
      imageWidth: double.infinity,
      imageHeight: double.infinity,
      beforeImage: Image.asset('assets/image/before_image.jpg', fit: BoxFit.cover),
      afterImage: Image.asset('assets/image/after_image.png', fit: BoxFit.cover),
    ),
  );
}
