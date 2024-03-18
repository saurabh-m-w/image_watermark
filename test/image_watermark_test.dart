import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:image_watermark/image_watermark.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';

void main() async{
  final imgOriginal = await (File('screenshots/screenshot1.png')).readAsBytes();
  final imgWatermark = await (File('screenshots/screenshot2.png')).readAsBytes();
  group('ImageWatermark', () {
    test('addTextWatermark', () async {
      final originalImageBytes = imgOriginal; // Simulated original image bytes
      final result = await ImageWatermark.addTextWatermark(
        imgBytes: originalImageBytes,
        watermarkText: 'Watermark Text',
        dstX: 50,
        dstY: 50,
        color: Colors.red,
      );
      expect(result, isA<Uint8List>());
    });

    test('addTextWatermarkCentered', () async {
      final originalImageBytes = imgOriginal; // Simulated original image bytes
      final result = await ImageWatermark.addTextWatermark(
        imgBytes: originalImageBytes,
        watermarkText: 'Centered Text',
        color: Colors.blue,
      );
      expect(result, isA<Uint8List>());
    });

    test('addImageWatermark', () async {
      final originalImageBytes = imgOriginal; // Simulated original image bytes
      final watermarkImageBytes = imgWatermark; // Simulated watermark image bytes
      final result = await ImageWatermark.addImageWatermark(
        originalImageBytes: originalImageBytes,
        waterkmarkImageBytes: watermarkImageBytes,
      );
      expect(result, isA<Uint8List>());
    });
  });
}
