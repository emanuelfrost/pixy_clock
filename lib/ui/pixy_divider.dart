import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';

import 'package:pixy_clock/ui/pixy_display_helper.dart';

import 'config.dart';

class PixyDivider extends CustomPainter {
  final Animation<double> noiseAnimation;
  final Animation<double> animation;
  final int cols = Config.PIXY_DISPLAY_CHAR_SQUARE_HORIZONTAL_COUNT;
  final int rows = Config.PIXY_DISPLAY_CHAR_SQUARE_VERTICAL_COUNT;

  final charMap = [
    Point(2, 0),
    Point(2, 1),
    Point(2, 12),
    Point(2, 13),
    Point(3, 0),
    Point(3, 1),
    Point(3, 12),
    Point(3, 13),
  ];

  Paint _pixyPaint;
  ValueNoise noise;
  Color color;
  int seed;

  PixyDivider(this.seed, this.noiseAnimation, this.animation, this.color)
      : super(repaint: animation) {
    _pixyPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = false
      ..color = color;

    noise = new ValueNoise(
        seed: seed, interp: Interp.Linear, octaves: 1, frequency: .25);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var pixySize = size.width / cols;

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        double n = PixyDisplayHelper.smoothen(
            PixyDisplayHelper.normalize(noise.singleValueFractalBillow3(
                col.toDouble(), row.toDouble(), noiseAnimation.value)),
            0.1);
        double pulseMod = animation.value.clamp(0.5, 1.0);
        var p = _pixyPaint..color = color.withOpacity(n * pulseMod);
        if (PixyDisplayHelper.numPixyMap[":"].contains(Point(col, row))) {
          canvas.drawRect(
              Rect.fromLTWH(
                  (pixySize * col), (pixySize * row), pixySize, pixySize),
              p);
        }
      }
    }
  }

  @override
  bool shouldRepaint(PixyDivider oldDelegate) {
    var sameAnimationValues = (animation.value == oldDelegate.animation.value);
    var sameNoiseAnimationValues =
        (noiseAnimation.value == oldDelegate.noiseAnimation.value);
    return !sameAnimationValues || !sameNoiseAnimationValues;
  }
}
