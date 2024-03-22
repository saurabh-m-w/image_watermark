# Image Watermark

## Languages

[![Spanish](https://img.shields.io/badge/Language-Spanish-blueviolet?style=for-the-badge)](README-es.md)

Image watermark is flutter pacakge to add text watermark and image watermark on image,you can customize the position of watermark and color.

Based on [Image](https://pub.dev/packages/image/) pacakge.

Check on [pub.dev](https://pub.dev/packages/image_watermark)

## Example code

Add watermark text at center of image,parameter image bytes and string and it returns image bytes

```dart
final watermarkedImg = 
  await ImageWatermark.addTextWatermark(
    imgBytes: imgBytes,
    watermarktext: 'watermarkText',
  );
```

```dart
final watermarkedImgBytes = 
    await ImageWatermark.addTextWatermark(
            imgBytes: imgBytes, ///image bytes
            watermarktext: 'watermarkText', ///watermark text
            color: Colors.white, ///default : Colors.black
          );
```

Change the position of watermark

```dart
final watermarkedImg = 
    await ImageWatermark.addTextWatermark(
            imgBytes: imgBytes,             ///image bytes
            watermarktext: 'watermarkText',      ///watermark text
            dstX: 20,                   ///position of watermark x coordinate
            dstY: 30,                   ///y coordinate
            color: Colors.green, ///default : Colors.black
          );
```

Add image as watermark on image

```dart
final watermarkedImgBytes = 
    await ImageWatermark.addImageWatermark(
            originalImageBytes: imgBytes,
            waterkmarkImageBytes: watermarkImgByte,
          );
```

```dart
final watermarkedImgBytes = 
    await ImageWatermark.addImageWatermark(
            originalImageBytes: imgBytes,  //image bytes
            waterkmarkImageBytes: imgBytes2, //watermark img bytes
            imgHeight: 200,   //watermark img height
            imgWidth: 200,    //watermark img width
            dstY: 400, //watermark position Y
            dstX: 400, //watermark position X
          );
```

### Add Fonts

`Image` package only have arial Fonts, you can change the font converting a .ttf font in .fnt format:

1. Download your font in .ttf format.

2. Convert the font to .fnt format using the next [site](https://ttf2fnt.com/).

3. Use `ImageFont` class, `readOtherFontZip` if you use .zip file; `readOtherFont` if you unzip and get the .fnt & .png files.

#### Example to change fonts

Add the font in pubspec.yaml:

```yaml
  assets:
  - path/to/font.zip
```

Then use it as follows:

```dart
final assetFont = await rootBundle.load('path/to/font.zip');

final font = assetFont.buffer.asUint8List(assetFont.offsetInBytes, assetFont.lengthInBytes);

final bitMapFont = ImageFont.readOtherFontZip(font);

...

await ImageWatermark.addTextWatermark(
  imgBytes: imgBytes,
  font: bitMapFont, /// Font from .zip
  watermarkText: 'watermark text',
  dstX: 20,
  dstY: 40,
)
```

## Screenshots

![Screenshot](https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot1.png "Screenshot 1")

![Screenshot](https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot2.png "Screenshot 2")

![Screenshot](https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot3.png "Screenshot 3")
