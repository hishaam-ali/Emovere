import 'dart:math';

import 'package:emotion_based_music_player/musicplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'captureimage.dart';

class emotion extends StatefulWidget {
  final String imagelocation;
  final String emotionname;
  const emotion({Key? key, required this.imagelocation, required this.emotionname}) : super(key: key);

  @override
  State<emotion> createState() => _emotionState();
}

_launchURLBrowser(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _emotionState extends State<emotion> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Emovere')),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Column(
            children: [
              Container( //show captured image
                padding: EdgeInsets.all(30),
                child: widget.imagelocation == null?
                Text("No image captured"):
                Image.file(File(widget.imagelocation), height:500,
                    width:double.infinity,),
                //display captured image
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.emotionname != 'no_face' && widget.emotionname!= 'many_face'
                    ? 'Identified Emotion : ' + widget.emotionname.toString() :
                widget.emotionname == 'no_face' ? 'No Face Detected' : 'Multiple Faces Detected',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),

              widget.emotionname == 'no_face' || widget.emotionname == 'many_face'? Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      fixedSize: Size(300, 50), //////// HERE
                    ),//image capture button
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CaptureImage()),
                      );
                    },
                    icon: Icon(CupertinoIcons.refresh_thick),
                    label: Text("Retry"),),
                )
              )
                  : Container(),

              widget.emotionname != 'no_face' && widget.emotionname != 'many_face'? Container(
             child:
             ElevatedButton.icon(
               style: ElevatedButton.styleFrom(
                 primary: Colors.green,
                 onPrimary: Colors.white,
                 shadowColor: Colors.greenAccent,
                 elevation: 3,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(32.0)),
                 fixedSize: Size(200, 50), //////// HERE
               ),//image capture button
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => musicplayer(emotion: widget.emotionname,)),
                 );
               },
                 icon: Icon(CupertinoIcons.music_note_2),
                  label: Text("Open Music Player"),)
              )
              :Container(
                height: 15,
              ),

              widget.emotionname != 'no_face' && widget.emotionname != 'many_face'? Container(

                child: Padding(
                  padding: const EdgeInsets.only(top:7.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      fixedSize: Size(200, 50), //////// HERE
                    ),//image capture button
                    onPressed: () {
                      var random = new Random();
                      var playlist = random.nextInt(4);
                      var playid;
                      if(widget.emotionname == 'Angry')
                      {
                        if(playlist == 0)
                          playid = "https://open.spotify.com/playlist/7fsU4QGmCxhwo45c9HGFQY?si=haMQtfjXSniqmI5EDYIUSg&utm_source=whatsapp";
                        else if(playlist == 1)
                          playid = "https://open.spotify.com/playlist/7LI3zw8HLkjKo5YpvA26KG?si=S8V-oVaCSvaRKwsGdIRaGg&utm_source=whatsapp";
                        else if(playlist == 2)
                          playid = "https://open.spotify.com/playlist/3uGngzu2qSCb672VyXwAqP?si=jzdMuDPpQ2GeGIxgTn5eQg&utm_source=whatsapp";
                        else if(playlist == 3)
                          playid = "https://open.spotify.com/playlist/5ZDpYAdAY8zssvfLVvq2e0?si=3TWqp0fdSue2RENdKqekAw&utm_source=whatsapp";
                        else
                          playid = "https://open.spotify.com/playlist/7jckO1aZEMjV6f90yvS6z3?si=3RJ4pNytSnaBxpWr2lK2xg&utm_source=whatsapp";
                        _launchURLBrowser(playid);
                      }
                      else if(widget.emotionname == 'Happy')
                      {
                        if(playlist == 0)
                          playid = "https://open.spotify.com/playlist/6H1fI9Xwo8xwRGEa7ydGXZ?si=JJxra6lSR0WwAYaXu8dQDw&utm_source=whatsapp&nd=1";
                        else if(playlist == 1)
                          playid = "https://open.spotify.com/playlist/5H11Ha4AnJmL0oEFwWywJS?si=gTdpQhZEShi8-GUsZqswUw&utm_source=whatsapp";
                        else if(playlist == 2)
                          playid = "https://open.spotify.com/playlist/0dWheZd3cdhezPTHles6Ms?si=pDekDsR8R72H7vjtIoVGcA&utm_source=whatsapp";
                        else if(playlist == 3)
                          playid = "https://open.spotify.com/playlist/0jrlHA5UmxRxJjoykf7qRY?si=0kXRjb6tRVqajEgA26B1pw&utm_source=whatsapp";
                        else
                          playid = "https://open.spotify.com/playlist/48TqjaOPdvmP1wPdimxUkI?si=hK0_6VB0ShiGKpc633GXyw&utm_source=whatsapp";
                        _launchURLBrowser(playid);
                      }
                      else
                      {
                        playlist = random.nextInt(2);
                        if(playlist == 0)
                          playid = "https://open.spotify.com/playlist/40JLahDJAUm5fP2NmdZhM0?si=SG-ovsZBTPmixB0cQ0PZtw&utm_source=whatsapp";
                        else if(playlist == 1)
                          playid = "https://open.spotify.com/playlist/3a8ssl2IKbhSmEzzIPYvbC?si=MDZ6ugNfRzWbNpZC8s_BNA&utm_source=whatsapp";
                        else
                          playid = "https://open.spotify.com/playlist/1HfmEbuAMYsHnnRWAx7B2X?si=7PDIEyhYTdipwvNDF_plqw&utm_source=whatsapp";
                        _launchURLBrowser(playid);
                      }
                    },
                    icon: Image.asset("assets/spotify.png") ,
                    label: Text("Open Spotify"),),
                )
              )
              : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
