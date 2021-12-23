import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';

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
  var _image;
  var watermarkedImgBytes;
  bool isLoading = false;
  String watermarkText = "";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image_watermark'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
            Padding(
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
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                watermarkedImgBytes = await image_watermark.addTextWatermark(
                    imgBytes, //image bytes
                    watermarkText, //watermark text
                    color: Colors.black, //default : Colors.white
                    dstX: 500, // default : imageWidth/4
                    dstY: 900); // default : imageWidth/2
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('Add Watermark'),
            ),
            isLoading ? CircularProgressIndicator() : Container(),
            Container(
              margin: EdgeInsets.all(15),
              width: 600,
              height: 250,
              child: watermarkedImgBytes == null
                  ? Container()
                  : Image.memory(watermarkedImgBytes),
            )
          ],
        ),
      ),
    );
  }
}
