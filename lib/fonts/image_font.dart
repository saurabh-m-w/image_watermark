import 'dart:typed_data';

import 'package:image/image.dart' as ui;

/// 1. Download your font in [.ttf] format
/// 2. Convert the font to [.fnt] format using the following link:
/// https://ttf2fnt.com/
/// 3. Use the converted font in the following method (zip or read Font)
abstract class ImageFont {
  /// For zip files
  static ui.BitmapFont readOtherFontZip(List<int> bytes) =>
      ui.readFontZip(bytes);

  /// For unzip files ([font] is the [.fnt] file and [imgBytes] is the [.png] file)
  static ui.BitmapFont readOtherFont(String font, Uint8List imgBytes) {
    final map = ui.decodeImage(imgBytes)!;
    return ui.readFont(font, map);
  }
}
