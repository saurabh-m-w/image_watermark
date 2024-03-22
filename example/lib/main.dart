import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'image_watermark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _picker = ImagePicker();
  Uint8List? imgBytes;
  Uint8List? imgBytes2;
  XFile? _image;
  Uint8List? watermarkedImgBytes;
  bool isLoading = false;
  String watermarkText = "", imgname = "image not selected";
  bool isLenovoFont = false;
  Uint8List? file;
  List<bool> textOrImage = [true, false];

  pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _image = image;
      var t = await image.readAsBytes();
      imgBytes = Uint8List.fromList(t);
    }
    setState(() {});
  }

  pickImage2() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _image = image;
      imgname = image.name;
      var t = await image.readAsBytes();
      imgBytes2 = Uint8List.fromList(t);
    }
    setState(() {});
  }

  changeFont() async {
    isLenovoFont = !isLenovoFont;
    if (isLenovoFont) {
      // Read file.zip from assets/fonts
      final assetFont = await rootBundle.load('assets/fonts/file.zip');
      file = assetFont.buffer.asUint8List(assetFont.offsetInBytes, assetFont.lengthInBytes);
    } else {
      file = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image_watermark'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      width: 600,
                      height: 250,
                      child: _image == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Click here to choose image')
                              ],
                            )
                          : Image.memory(imgBytes!,
                              width: 600, height: 200, fit: BoxFit.fitHeight)),
                ),
                ToggleButtons(
                  fillColor: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderWidth: 3,
                  borderColor: Colors.black26,
                  selectedBorderColor: Colors.black54,
                  selectedColor: Colors.black,
                  onPressed: (index) {
                    textOrImage = [false, false];
                    setState(() {
                      textOrImage[index] = true;
                    });
                  },
                  isSelected: textOrImage,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '  Text  ',
                      ),
                    ),
                    // second toggle button
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '  Image  ',
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                textOrImage[0]
                    ? Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async => await changeFont(),
                            child: Text(
                                'Change Font ${isLenovoFont ? 'Arial' : 'Lenovo'}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              width: 600,
                              child: TextField(
                                onChanged: (val) {
                                  watermarkText = val;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Watermark Text',
                                  hintText: 'Watermark Text',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          ElevatedButton(
                              onPressed: pickImage2,
                              child: const Text('Select Watermark image')),
                          Text(imgname)
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (textOrImage[0]) {
                      watermarkedImgBytes =
                          await ImageWatermark.addTextWatermark(
                        ///image bytes
                        imgBytes: imgBytes!,

                        /// Change font
                        font: isLenovoFont
                            ? ImageFont.readOtherFontZip(file!)
                            : null,

                        ///watermark text
                        watermarkText: watermarkText,
                        dstX: 20,
                        dstY: 30,
                      );

                      /// default : imageWidth/2
                    } else {
                      watermarkedImgBytes =
                          await ImageWatermark.addImageWatermark(
                              //image bytes
                              originalImageBytes: imgBytes!,
                              waterkmarkImageBytes: imgBytes2!,
                              imgHeight: 250,
                              imgWidth: 250,
                              dstY: 400,
                              dstX: 400);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text('Add Watermark'),
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading ? const CircularProgressIndicator() : Container(),
                watermarkedImgBytes == null
                    ? const SizedBox()
                    : Image.memory(watermarkedImgBytes!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
