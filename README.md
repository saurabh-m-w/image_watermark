# image_watermark

Image watermark is flutter pacakge to add text watermark and image watermark on image,you can customize the position of watermark and color.
Based on [Image](https://pub.dev/packages/image/) pacakge.\
Check on pub.dev: https://pub.dev/packages/image_watermark

## Example code
Add watermark text at center of image,parameter image bytes and string and it returns image bytes
```dart
final watermarkedImg = await ImageWatermark.addTextWatermarkCentered(
  imgBytes: imgBytes,
  watermarktext: 'watermarkText',
  );
```

```dart
final watermarkedImgBytes = await ImageWatermark.addTextWatermarkCentered(
                        imgBytes: imgBytes, ///image bytes
                        watermarktext: 'watermarkText', ///watermark text
                        color: Colors.white, ///default : Colors.black
                      );
```
Change the position of watermark
```dart
final watermarkedImg = await ImageWatermark.addTextWatermark(
                          imgBytes: imgBytes,             ///image bytes
                          watermarktext: 'watermarkText',      ///watermark text
                          dstX: 20,                   ///position of watermark x coordinate
                          dstY: 30,                   ///y coordinate
                          color: Colors.green, ///default : Colors.black
                        )
```
Add image as watermark on image
```dart
final watermarkedImgBytes = await ImageWatermark.addImageWatermark(
  originalImageBytes: imgBytes,
  waterkmarkImageBytes: watermarkImgByte,
  );
```

```dart
final watermarkedImgBytes = await ImageWatermark.addImageWatermark(
                              originalImageBytes: imgBytes,  //image bytes
                              waterkmarkImageBytes: imgBytes2, //watermark img bytes
                              imgHeight: 200,   //watermark img height
                              imgWidth: 200,    //watermark img width
                              dstY: 400,
                              dstX: 400,
                              );
```

<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot1.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot2.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot3.png" height="400">
