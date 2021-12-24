# image_watermark

Image watermark is flutter pacakge to add text watermark and image watermark on image,you can customize the position of watermark and color.
Based on [Image](https://pub.dev/packages/image/) pacakge.\
Check on pub.dev: https://pub.dev/packages/image_watermark

## Example code
Add watermark text at center of image,parameter image bytes and string and it returns image bytes
```dart
var watermarkedImg = await image_watermark.addTextWatermarkCentered(imgBytes,'watermarkText');
```

```dart
var watermarkedImgBytes = await image_watermark.addTextWatermarkCentered(
                        imgBytes, ///image bytes
                        watermarkText, ///watermark text
                        color: Colors.black, ///default : Colors.white
                      );
```
Change the position of watermark
```dart
var watermarkedImg = await image_watermark.addTextWatermark(
                          imgBytes,             ///image bytes
                          'watermarkText',      ///watermark text
                          20,                   ///position of watermark x coordinate
                          30,                   ///y coordinate
                          color: Colors.green, ///default : Colors.white
                        )
```
Add image as watermark on image
```dart
watermarkedImgBytes = await image_watermark.addImageWatermark(imgBytes,watermarkImgByte);
```

```dart
watermarkedImgBytes = await image_watermark.addImageWatermark(
                              imgBytes, //image bytes
                              imgBytes2,//watermark img bytes
                              imgHeight: 200,   //watermark img height
                              imgWidth: 200,    //watermark img width
                              dstY: 400,
                              dstX: 400);
```

<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot1.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot2.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot3.png" height="400">