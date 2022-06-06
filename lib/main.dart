import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:emotion_based_music_player/captureimage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: 'assets/logo.png',
            nextScreen: CaptureImage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.white));
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    );
  }
}










// import 'dart:async';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:camera/camera.dart';
// import 'package:emotion_based_music_player/captureimage.dart';
// import 'package:emotion_based_music_player/frontpage.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:page_transition/page_transition.dart';
// List<CameraDescription>? cameras;
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(new MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: 'assets/logo.png',
//       nextScreen: CaptureImage(),
//       splashTransition: SplashTransition.rotationTransition,
//       pageTransitionType: PageTransitionType.scale,
//     );
//     //   MaterialApp(
//     //   theme: ThemeData(
//     //     primaryColor: Colors.black
//     //   ),
//     //   debugShowCheckedModeBanner: false,
//     //   home: FrontPage(),
//     // );
//   }
// }
