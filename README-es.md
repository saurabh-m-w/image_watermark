# Image Watermark

## Idiomas

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README.md)

Image watermark es un paquete de flutter para agregar a cualquier imagen textos u otras imágenes como marcas de agua, puedes personalizar la posición de la marca de agua y el color.

Basado en el paquete [Image](https://pub.dev/packages/image/).

Publicado en [pub.dev](https://pub.dev/packages/image_watermark)

## Código de Ejemplo

Agrega texto en el centro de la Imagen como marca de agua, los parametros son la imagen convertida a Uint8List y el texto (String), se retorna una imagen en Uint8List

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
            imgBytes: imgBytes, ///Imagen en Uint8List
            watermarktext: 'watermarkText', ///texto marca de agua text
            color: Colors.white, ///default : Colors.black
          );
```

Cambia la posición de la marca de agua

```dart
final watermarkedImg = 
    await ImageWatermark.addTextWatermark(
            imgBytes: imgBytes,             ///Imagen en Uint8List
            watermarktext: 'watermarkText',      ///texto marca de agua
            dstX: 20,                   ///posición de la marca de agua (coordenadas de X)
            dstY: 30,                   ///posición de la marca de agua (coordenadas de Y)
            color: Colors.green, ///default : Colors.black
          );
```

Agrega una Imagen como marca de agua en otra Imagen

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
            originalImageBytes: imgBytes,  //Imagen Principal en Uint8List
            waterkmarkImageBytes: imgBytes2, //Imagen marca de agua en Uint8List
            imgHeight: 200,   //Altura de la imagen marca de agua
            imgWidth: 200,    //Anchura de la imagen marca de agua
            dstY: 400, //posición de la marca de agua (coordenadas de Y)
            dstX: 400, //posición de la marca de agua (coordenadas de X)
          );
```

### Agregar Fuentes

El paquete `Image` solo tiene fuentes arial, puedes cambiar la fuente convirtiendo un archivo de formato .ttf en formato .fnt:

1. Descarga tu fuente en formato .ttf.

2. Convierte tu fuente en formato .fnt usando el siguiente [sitio](https://ttf2fnt.com/).

3. Usa la clase `ImageFont`, `readOtherFontZip` si usas el archivo .zip; `readOtherFont` si descomprimes el archivo .zip y obtienes los archivos .fnt & .png.

#### Ejemplo para cambiar fuentes

Agrega la fuente en el pubspec.yaml

```yaml
  assets:
  - path/to/font.zip
```

Después usala de la siguiente forma:

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
