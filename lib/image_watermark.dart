import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ui;

class ImageWatermark {
  ///This method adds the text that is indicated as a watermark,
  ///the parameters are the following:
  /// ```
  /// await addTextWatermark(
  ///   imgBytes : //Image converted to Uint8List
  ///   watermarkText: //The text
  ///   dstX: //X coordinates in the image
  ///   dstY: //Y coordinates in the image
  ///   font: //Text font type (default arial_48)
  ///   color: //Text color (default black)
  ///   rightJustify: //Text right justification (default false)
  /// );
  /// ```
  static Future<Uint8List> addTextWatermark({
    ///Image converted to Uint8List
    required Uint8List imgBytes,

    ///The text
    required String watermarkText,

    ///X coordinates in the image
    required int dstX,

    ///Y coordinates in the image
    required int dstY,

    ///Text font type
    ui.BitmapFont? font,

    ///Text color
    Color color = Colors.black,

    ///Text right justification
    bool rightJustify = false,
  }) async {
    ///Original Image
    final originalImage = ui.decodeImage(imgBytes)!;

    ///Add Watermark
    ui.drawString(
      originalImage,
      font ?? ui.arial_48,
      dstX,
      dstY,
      watermarkText,
      color: color.value,
      rightJustify: rightJustify,
    );

    ///Encode image to PNG
    final wmImage = ui.encodePng(originalImage);

    ///Get the result
    final result = Uint8List.fromList(wmImage);

    return result;
  }

  ///This method adds the text that is indicated as a watermark, but centered
  ///the parameters are the following:
  /// ```
  /// await addTextWatermarkCentered(
  ///   imgBytes : //Image converted to Uint8List
  ///   watermarkText: //The text
  ///   font: //Text font type (default arial_48)
  ///   color: //Text color (default black)
  /// );
  /// ```
  static Future<Uint8List> addTextWatermarkCentered({
    ///Image converted to Uint8List
    required Uint8List imgBytes,

    ///The text
    required String watermarktext,

    ///Text font type
    ui.BitmapFont? font,

    ///Text color (default black)
    Color color = Colors.black,
  }) async {
    ///Original Image
    final originalImage = ui.decodeImage(imgBytes)!;

    ///Add Watermark
    ui.drawStringCentered(
      originalImage,
      font ?? ui.arial_48,
      watermarktext,
      color: color.value,
    );

    ///Encode image to PNG
    final wmImage = ui.encodePng(originalImage);

    ///Get the result
    final result = Uint8List.fromList(wmImage);

    return result;
  }

  ///This method adds the image that is indicated as a watermark,
  ///the parameters are the following:
  /// ```
  /// await addImageWatermark(
  ///   originalImageBytes : //Original Image converted to Uint8List
  ///   waterkmarkImageBytes: //Watermark Image converted to Uint8List
  ///   dstX: //X coordinates in the image (default 100)
  ///   dstY: //Y coordinates in the image (default 100)
  ///   imgHeight: //Image height (default 100)
  ///   imgWidth: //Image width (default 100)
  /// );
  /// ```
  static Future<Uint8List> addImageWatermark({
    required Uint8List originalImageBytes,
    required Uint8List waterkmarkImageBytes,
    int imgHeight = 100,
    int imgWidth = 100,
    int dstX = 100,
    int dstY = 100,
  }) async {
    ///Original Image
    final original = ui.decodeImage(originalImageBytes)!;

    ///Watermark Image
    final watermark = ui.decodeImage(waterkmarkImageBytes)!;

    // add watermark over originalImage
    // initialize width and height of watermark image
    final image = ui.Image(imgHeight, imgWidth);
    ui.drawImage(image, watermark);

    // give position to watermark over image
    ui.copyInto(
      original,
      image,
      dstX: dstX,
      dstY: dstY,
    );

    ///Encode image to PNG
    final wmImage = ui.encodePng(original);

    ///Get the result
    final result = Uint8List.fromList(wmImage);

    return result;
  }
}
