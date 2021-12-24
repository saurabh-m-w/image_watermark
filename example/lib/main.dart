import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';
//import 'package:example/image_watermark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'image_watermark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  var imgBytes;
  var imgBytes2;
  var _image;
  var watermarkedImgBytes;
  bool isLoading = false;
  String watermarkText = "", imgname = "image not selected";
  List<bool> textOrImage = [true, false];

  pickImage() async {
    XFile? image = await _picker.pickImage(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image_watermark'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: 600,
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      width: 600,
                      height: 250,
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Click here to choose image')
                              ],
                            )
                          : Image.memory(imgBytes,
                              width: 600, height: 200, fit: BoxFit.fitHeight)),
                ),
                ToggleButtons(
                  fillColor: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderWidth: 3,
                  borderColor: Colors.black26,
                  selectedBorderColor: Colors.black54,
                  selectedColor: Colors.black,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Text  ',
                      ),
                    ),
                    // second toggle button
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '  Image  ',
                        ))
                  ],
                  onPressed: (index) {
                    textOrImage = [false, false];
                    setState(() {
                      textOrImage[index] = true;
                    });
                  },
                  isSelected: textOrImage,
                ),
                SizedBox(
                  height: 10,
                ),
                textOrImage[0]
                    ? Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          width: 600,
                          child: TextField(
                            onChanged: (val) {
                              watermarkText = val;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Watermark Text',
                              hintText: 'Watermark Text',
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          ElevatedButton(
                              onPressed: pickImage2,
                              child: Text('Select Watermark image')),
                          Text(imgname)
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (textOrImage[0]) {
                      watermarkedImgBytes =
                          await image_watermark.addTextWatermark(
                        imgBytes,

                        ///image bytes
                        watermarkText, //watermark text
                        20, //
                        30,
                        color: Colors.black, //default : Colors.white
                      );

                      /// default : imageWidth/2
                    } else {
                      watermarkedImgBytes =
                          await image_watermark.addImageWatermark(
                              imgBytes, //image bytes
                              imgBytes2,
                              imgHeight: 200,
                              imgWidth: 200,
                              dstY: 400,
                              dstX: 400);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text('Add Watermark'),
                ),
                SizedBox(
                  height: 10,
                ),
                isLoading ? CircularProgressIndicator() : Container(),
                watermarkedImgBytes == null
                    ? Container()
                    : Image.memory(watermarkedImgBytes),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
