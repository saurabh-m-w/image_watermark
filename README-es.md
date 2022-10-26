# image_watermark

<div align="center">
**Idiomas:**
[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README.md)
</div>

Image watermark es un paquete de flutter para agregar a cualquier imagen textos u otras imágenes como marcas de agua, puedes personalizar la posición de la marca de agua y el color. Basado en el paquete [Image](https://pub.dev/packages/image/).\
Publicación del paquete: https://pub.dev/packages/image_watermark

## Código de Ejemplo
Agrega texto en el centro de la Imagen como marca de agua, los parametros son la imagen convertida a Uint8List y el texto (String), se retorna una imagen en Uint8List
```dart
final watermarkedImg = await ImageWatermark.addTextWatermarkCentered(
  imgBytes: imgBytes,
  watermarktext: 'watermarkText',
  );
```

```dart
final watermarkedImgBytes = await ImageWatermark.addTextWatermarkCentered(
                        imgBytes: imgBytes, ///Imagen en Uint8List
                        watermarktext: 'watermarkText', ///texto marca de agua
                        color: Colors.white, ///default : Colors.black
                      );
```
Cambia la posición de la marca de agua
```dart
final watermarkedImg = await ImageWatermark.addTextWatermark(
                          imgBytes: imgBytes,             ///Imagen en Uint8List
                          watermarktext: 'watermarkText',      ///texto marca de agua
                          dstX: 20,                   ///posición de la marca de agua (coordenadas de X)
                          dstY: 30,                   ///posición de la marca de agua (coordenadas de Y)
                          color: Colors.green, ///default : Colors.black
                        )
```
Agrega una Imagen como marca de agua en otra Imagen
```dart
final watermarkedImgBytes = await ImageWatermark.addImageWatermark(
  originalImageBytes: imgBytes,
  waterkmarkImageBytes: watermarkImgByte,
  );
```

```dart
final watermarkedImgBytes = await ImageWatermark.addImageWatermark(
                              originalImageBytes: imgBytes,  ///Imagen Principal en Uint8List
                              waterkmarkImageBytes: imgBytes2, ///Imagen marca de agua en Uint8List
                              imgHeight: 200,   ///Altura de la imagen marca de agua
                              imgWidth: 200,    ///Anchura de la imagen marca de agua
                              dstY: 400,        ///posición de la marca de agua (coordenadas de Y)
                              dstX: 400,        ///posición de la marca de agua (coordenadas de X)
                              );
```

<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot1.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot2.png" height="400">
<img src="https://raw.githubusercontent.com/saurabh-m-w/image_watermark/main/screenshots/screenshot3.png" height="400">
