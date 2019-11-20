import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:pixy_clock/ui/config.dart';

import 'package:pixy_clock/ui/pixy_display_helper.dart';

class PixyNumber extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> transitionAnimation;
  final int cols = Config.PIXY_DISPLAY_CHAR_SQUARE_HORIZONTAL_COUNT;
  final int rows = Config.PIXY_DISPLAY_CHAR_SQUARE_VERTICAL_COUNT;

  Paint _pixyPaint;
  PixyNumberUpdate char;
  ValueNoise noise;
  ValueNoise noise2;
  Color color;
  int seed;

  PixyNumber(this.char, this.seed, this.animation, this.transitionAnimation,
      this.color)
      : super(repaint: animation) {
    _pixyPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = false
      ..color = color;

    noise = new ValueNoise(
        seed: seed, interp: Interp.Linear, octaves: 1, frequency: .25);
    noise2 = new ValueNoise(
        seed: seed, interp: Interp.Linear, octaves: 1, frequency: .25);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var pixySize = size.width / cols;

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        var isCurrentChar = PixyDisplayHelper.numPixyMap[char.currentNumber]
            .contains(Point(col, row));
        var isPrevChar = PixyDisplayHelper.numPixyMap[char.prevNumber]
            .contains(Point(col, row));

        if (isCurrentChar || isPrevChar) {
          double noiseOpacity = PixyDisplayHelper.smoothen(
              PixyDisplayHelper.normalize(noise.singleValueFractalBillow3(
                  col.toDouble(), row.toDouble(), animation.value)),
              0.15);
          double transitionTime = transitionAnimation.value;

          double startTime = PixyDisplayHelper.normalize(
                  noise2.singleValueFractalFBM2(col.toDouble(), row.toDouble()))
              .clamp(0.1, 0.7);
          double fadeTime = 1 - startTime;

          if (isCurrentChar) {
            double fadeInValue = max(0, transitionTime - startTime) / fadeTime;
            var v = noiseOpacity * fadeInValue;
            var p = _pixyPaint..color = color.withOpacity(v);
            canvas.drawRect(
                Rect.fromLTWH(
                    (pixySize * col), (pixySize * row), pixySize, pixySize),
                p);
          }

          if (isPrevChar) {
            double fadeOutValue =
                1 - max(0, transitionTime - startTime) / fadeTime;
            var v = noiseOpacity * fadeOutValue;
            var p = _pixyPaint..color = color.withOpacity(v);
            canvas.drawRect(
                Rect.fromLTWH(
                    (pixySize * col), (pixySize * row), pixySize, pixySize),
                p);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(PixyNumber oldDelegate) {
    var sameAnimationValues = (animation.value == oldDelegate.animation.value);
    var sameCharacter = (char == oldDelegate.char);
    return !sameAnimationValues || !sameCharacter;
  }
}

class PixyNumberUpdate {
  final String currentNumber;
  final String prevNumber;

  PixyNumberUpdate(this.currentNumber, this.prevNumber);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PixyNumberUpdate &&
          runtimeType == other.runtimeType &&
          currentNumber == other.currentNumber &&
          prevNumber == other.prevNumber;

  @override
  int get hashCode => currentNumber.hashCode ^ prevNumber.hashCode;
}
