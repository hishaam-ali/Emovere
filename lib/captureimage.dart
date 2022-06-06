import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'emotion.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({Key? key}) : super(key: key);

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  CameraImage? cameraImage;
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image
  String output = '';
  int camno = 1;
  File? _selectedImage;
  bool imagenottaken = true;
  String url = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![camno], ResolutionPreset.medium);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
        });
      });
    }else{
      print("NO any camera found");
    }
  }

  Future<http.Response> getFaceCoordinate(File file, String link) async {
    ///MultiPart request
    String filename = file.path.split('/').last;
    print(filename);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(link),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print("This is response:" + response.body);
    print("This is response: ${res.statusCode} ");
    print("This is response: ${res.statusCode} ");
    return response;
  }

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Emovere")),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: imagenottaken ? Container(
            child: Column(
                children:[
                  Center(
                    child: Container(
                        height:500,
                        width:double.infinity,

                        child: controller == null?
                        Center(child:Text("Loading Camera...")):
                        !controller!.value.isInitialized?
                        Center(
                          child: CircularProgressIndicator(),
                        ):
                        CameraPreview(controller!)
                    ),
                  ),
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                    children: [

                      ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(150, 50), //////// HERE
                  ),//image capture button
                        onPressed: () async{
                          try {
                            if(controller != null){ //check if controller is not null
                              if(controller!.value.isInitialized){ //check if controller is initialized
                                image = await controller!.takePicture();
                                _selectedImage = File(image!.path);
                                setState(() {
                                  imagenottaken = false;
                                });
                                final res = await getFaceCoordinate(
                                    File(_selectedImage!.path), "http://c420-2402-3a80-1e71-5f1-d475-81dd-b2da-2605.ngrok.io/emotion_detection");
                                debugPrint(res.body);
                                final val = jsonDecode(res.body);
                                output = val['emotion'] ?? 'empty';
                                if(output == 'empty') {
                                  setState(() {
                                    imagenottaken = true;
                                  });
                                }
                                if(output != 'empty') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        emotion(imagelocation: image!.path,
                                          emotionname: output,)),
                                  );
                                }
                              }
                            }
                          } catch (e) {
                            print(e); //show error
                          }
                        },
                        icon: Icon(Icons.camera),
                        label: Text("Identify Emotion"),
                      ),
                    ],
                  ),
                ]
            )
        ) : SpinKitWave(
          color: Colors.black,
          size: 50.0,
        )
      ),
    );
  }
}
