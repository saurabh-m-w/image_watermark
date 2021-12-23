library image_watermark;

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ui;

class image_watermark {
  static Future<Uint8List> addTextWatermark(
      Uint8List imgBytes, String watermarktext,
      {Color color = Colors.black, int dstX = -1, int dstY = -1}) async {
    ui.Image originalImage = ui.decodeImage(imgBytes) as ui.Image;
    if (dstX == -1) dstX = (originalImage.width / 4).toInt();
    if (dstY == -1) dstY = (originalImage.height / 2).toInt();

    ui.drawString(originalImage, ui.arial_48, dstX, dstY, watermarktext,
        color: color.value);

    List<int> wmImage = ui.encodePng(originalImage);
    Uint8List res = Uint8List.fromList(wmImage);
    return res;
  }
}
