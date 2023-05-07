import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageSliderThumbShape extends SliderComponentShape {
  final ui.Image image;
  final double size;
  final Offset positionOffset;

  ImageSliderThumbShape({required this.image, this.size = 24.0, this.positionOffset = Offset.zero});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(size / 2);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = size;
    final imageHeight = size;
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(
          center.dx - imageWidth / 2 + positionOffset.dx,
          center.dy - imageHeight / 2 + positionOffset.dy,
          imageWidth,
          imageHeight),
      image: image,
      fit: BoxFit.fill,
    );
  }
}
