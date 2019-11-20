import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

import 'package:pixy_clock/ui/config.dart';
import 'package:pixy_clock/ui/pixy_display_helper.dart';

class PixyBackground extends CustomPainter {
  final Animation<double> animation;
  final int cols = Config.PIXY_COLS;
  final int rows = Config.PIXY_ROWS;

  Paint _pixyPaint;
  Paint _pixyBackgroundPaint;
  var noise;
  Color foregroundColor;
  Color backgroundColor;

  PixyBackground(this.animation, this.backgroundColor, this.foregroundColor)
      : super(repaint: animation) {
    noise = new ValueNoise(interp: Interp.Linear, octaves: 1, frequency: .25);

    _pixyPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = false
      ..color = foregroundColor;

    _pixyBackgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = false
      ..color = backgroundColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var pixySize = size.width / cols;
    Rect r = Offset.zero & size;

    canvas.drawRect(r, _pixyBackgroundPaint);

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        double n = PixyDisplayHelper.smoothen(
            PixyDisplayHelper.normalize(noise.singleValueFractalBillow3(
                col.toDouble(), row.toDouble(), animation.value)),
            0.05);
        var p = _pixyPaint..color = foregroundColor.withOpacity(n);
        canvas.drawRect(
            Rect.fromLTWH(
                (pixySize * col), (pixySize * row), pixySize, pixySize),
            p);
      }
    }
  }

  @override
  bool shouldRepaint(PixyBackground oldDelegate) {
    var sameAnimationValues = (animation.value == oldDelegate.animation.value);
    return !sameAnimationValues;
  }
}
