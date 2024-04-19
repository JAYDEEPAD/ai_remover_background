import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TickSliderDemo extends StatefulWidget {
  @override
  _TickSliderDemoState createState() => _TickSliderDemoState();
}

class _TickSliderDemoState extends State<TickSliderDemo> {
  double _value = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tick Slider Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SfSliderTheme(
            data: SfSliderThemeData(
              tickOffset: Offset(0.0, 10.0),
            ),
            child: Transform.scale(
              scale: 1.5,
              child: SfSlider(
                min: 2.0,
                max: 10.0,
                interval: 2,
                minorTicksPerInterval: 1,
                //showLabels: true,
                showTicks: true,
                value: _value,
                onChanged: (dynamic newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
