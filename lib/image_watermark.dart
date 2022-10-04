library image_watermark;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ui;

class image_watermark {

  static Future<Uint8List> addTextWatermark(
      Uint8List imgBytes, String watermarktext, int dstX, int dstY,ui.BitmapFont arial, {Color color = Colors.black}) async {
    ui.Image originalImage = ui.decodeImage(imgBytes) as ui.Image;

    ui.drawString(originalImage, arial, dstX, dstY, watermarktext,
        color: color.value);
        
    List<int> wmImage = ui.encodePng(originalImage);
    Uint8List res = Uint8List.fromList(wmImage);
    return res;
  }

  static Future<Uint8List> addTextWatermarkCentered(
      Uint8List imgBytes, String watermarktext,
      {Color color = Colors.black}) async {
    ui.Image originalImage = ui.decodeImage(imgBytes) as ui.Image;

    ui.drawStringCentered(originalImage, ui.arial_48, watermarktext);

    List<int> wmImage = ui.encodePng(originalImage);
    Uint8List res = Uint8List.fromList(wmImage);
    return res;
  }

  static Future<Uint8List> addImageWatermark(
      Uint8List imgBytes, Uint8List imgBytes2,
      {int imgHeight = 100,
      int imgWidth = 100,
      int dstX = 100,
      int dstY = 100}) async {
    ui.Image originalImage = ui.decodeImage(imgBytes) as ui.Image;
    ui.Image watermarkImage = ui.decodeImage(imgBytes2) as ui.Image;

    // add watermark over originalImage
    // initialize width and height of watermark image
    ui.Image image = ui.Image(imgHeight, imgWidth);
    ui.drawImage(image, watermarkImage);

    // give position to watermark over image
    ui.copyInto(originalImage, image, dstX: dstX, dstY: dstY);

    List<int> wmImage = ui.encodePng(originalImage);
    Uint8List res = Uint8List.fromList(wmImage);
    return res;
  }
}
