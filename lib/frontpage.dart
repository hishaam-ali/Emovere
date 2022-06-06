import 'package:emotion_based_music_player/captureimage.dart';
import 'package:emotion_based_music_player/musicplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Center(
          child: Column(
            children: [
              Text('Logo'),
              Container(
                color: Colors.black,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CaptureImage()),
                      );
                    },
                    child: Text('Get started')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
