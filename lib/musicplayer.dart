import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:emotion_based_music_player/captureimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:unicons/unicons.dart';

import 'package:flutter/services.dart' as rootBundle;

class musicplayer extends StatefulWidget {
  final String emotion;
  const musicplayer({Key? key, required this.emotion}) : super(key: key);

  @override
  State<musicplayer> createState() => _musicplayerState();
}


class _musicplayerState extends State<musicplayer> {

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool repeat = false;

  String imagelink = 'assets/happy/1.jfif';
  String songtitle = '';
  int endsize = 0;
  String singer = '';
  String singerpath = '';
  int id = 0;

  String jsonfilename = 'happysongs.json';
  final List<String> imagesh = ['assets/happy/1.jfif','assets/happy/2.jfif','assets/happy/3.jfif',
    'assets/happy/4.jfif','assets/happy/5.jfif','assets/happy/6.jfif',
    'assets/happy/7.jfif','assets/happy/8.jfif','assets/happy/9.jfif',
    'assets/happy/10.jfif','assets/happy/11.jfif','assets/happy/12.jfif',
    'assets/happy/13.jfif','assets/happy/14.jfif','assets/happy/15.jfif',
    'assets/happy/16.jfif','assets/happy/17.jfif','assets/happy/18.jfif',
    'assets/happy/19.jfif','assets/happy/20.jfif','assets/happy/21.jfif',
    'assets/happy/22.jfif','assets/happy/23.jfif','assets/happy/24.jfif',
    'assets/happy/25.jfif','assets/happy/26.jfif','assets/happy/27.jfif',
    'assets/happy/28.jfif','assets/happy/29.jfif','assets/happy/30.jfif'
  ];
  final List<String> imagesa = ['assets/angry/01.jpg','assets/angry/02.jpg','assets/angry/03.png',
    'assets/angry/04.jfif','assets/angry/05.jfif','assets/angry/06.jpg',
    'assets/angry/07.png','assets/angry/08.jpg','assets/angry/09.jpg',
    'assets/angry/10.jpg','assets/angry/11.jpg','assets/angry/12.jpg',
    'assets/angry/13.png','assets/angry/14.jpg','assets/angry/15.jpg',
    'assets/angry/16.jpg','assets/angry/17.jfif','assets/angry/18.jfif',
    'assets/angry/19.jfif','assets/angry/20.jfif','assets/angry/21.jfif',
    'assets/angry/22.jfif','assets/angry/23.jfif','assets/angry/24.jfif',
    'assets/angry/25.jfif','assets/angry/26.png','assets/angry/27.jfif',
    'assets/angry/28.jfif','assets/angry/29.jfif','assets/angry/30.jfif'
  ];
  final List<String> imagess = ['assets/sad/01.jfif','assets/sad/02.jfif','assets/sad/03.jfif',
    'assets/sad/04.jfif','assets/sad/05.jfif','assets/sad/06.png',
    'assets/sad/07.jfif','assets/sad/08.jfif','assets/sad/09.jfif',
    'assets/sad/10.jfif','assets/sad/11.jfif','assets/sad/12.jfif',
    'assets/sad/13.jfif','assets/sad/14.jfif','assets/sad/15.jfif',
    'assets/sad/16.jfif','assets/sad/17.jfif','assets/sad/18.jfif',
    'assets/sad/19.jfif','assets/sad/20.jfif','assets/sad/21.jpg',
    'assets/sad/22.jfif','assets/sad/23.jfif','assets/sad/24.jfif',
    'assets/sad/25.jfif','assets/sad/26.jfif','assets/sad/27.jfif',
    'assets/sad/28.jfif','assets/sad/29.jfif','assets/sad/30.jfif'
  ];
  late List<PaletteColor> colors;
  late List<PaletteColor> shades;
  List data = [];
  late int _currentIndex;
  //int _currentIndex = 0;
  List<String> images = [];

  int flag=0;
  int flag_=0;
  bool musicobtained = false;

  @override
  void initState(){
    super.initState();
    fetchData();
    colors =[];
    shades=[];
    _currentIndex=0;
    _updatePalettes();
  }
  _updatePalettes() async {
    if(widget.emotion == 'Happy'){
      images = imagesh;
    }
    else if(widget.emotion == 'Angry') {
      images = imagesa;
    }
    else {
      images = imagess;
    }
    //for(int i=0; i<30; i++)
      //{
    for(String image in images) {
      //String image = images[i];
        PaletteGenerator generator = await
          PaletteGenerator.fromImageProvider(
            AssetImage(image),
            size: Size(100,100)
          );
      colors.add(generator.lightMutedColor ?? PaletteColor(Colors.white, 2));
      shades.add(generator.darkMutedColor ?? PaletteColor(Colors.black, 2));
    }
    //setState(() {});
  }

  setAudio() async{
    if(data.length > 0) {
      if(flag_ == 0) {
        flag_ = 1;
        var random = new Random();
        id = random.nextInt(29);
        _currentIndex = id;
      }
      songtitle = await data[id]['name'];
      singer =  await data[id]['singer'];
      imagelink =  await data[id]['imageUrl'];
      final url1 = data[id]['songtitle'].toString();
      String url = "https://drive.google.com/uc?export=view&id=" + url1;
      audioPlayer.setUrl(url);
      audiocheck();
    }
  }

  void audiocheck() {
    //listen to states : playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    //listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //listen to audio position
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    //audioPlayer.onSeekComplete.listen((event) { });
    audioPlayer.onPlayerCompletion.listen((event) async{
      setState(() {
        position = Duration.zero;
        print(id);
        if(id == 0 && flag == 1) {
          id = 0;
          flag = 0;
          _currentIndex = id;
          //setAudio();
        }
        else if(id == 29) {
          id = 0;
          _currentIndex = id;
          flag = 1;
          print("new id = " + id.toString());
        }
        else {
          id++;
          _currentIndex = id;
        }
        setAudio();
        print("id new = " + id.toString());
      });
      await audioPlayer.resume();
    });
  }

  //setAudio();


  void fetchData() async {
    if(widget.emotion == 'Happy'){
      jsonfilename = 'happysongs.json';
    }
    else if(widget.emotion == 'Angry') {
      jsonfilename = 'angrysongs.json';
    }
    else {
      jsonfilename = 'sadsongs.json';
    }
    String response = await DefaultAssetBundle.of(context).loadString("assets/" + jsonfilename);
    data = jsonDecode(response);
    print(data);
    setAudio();
    musicobtained = true;
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {

    print(colors.length);
    print(shades.length);
    //print(images.length)
    //print(imagesa.length);
    //print(imagesh.length);
    //print(imagess.length);
    //while(colors.length < 30 && shades.length < 30)
      //_updatePalettes();

    return Scaffold(
      backgroundColor: colors.isNotEmpty? colors[_currentIndex].color : Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: shades.isNotEmpty? shades[_currentIndex].color : Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
          ),
          onPressed: (){},
        ),
        title: const Text('Now Playing'),
        automaticallyImplyLeading: false,
      ),
      body: musicobtained ? Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25,),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(imagelink,
              //Image.network("https://list23.com/img/the-weeknd-is-an-old-man-in-his-newly-unveiled-dawn-fm-album-cover.jpeg",
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 25,),
            Text(
              songtitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 4,),
            Text(
              singer,
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              activeColor: shades.isNotEmpty? shades[_currentIndex].color : Theme.of(context).primaryColor,
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                //option : play audio if was paused
                //await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    repeat ? CupertinoIcons.repeat_1 :  CupertinoIcons.repeat,size: 40,
                  ),
                  tooltip: 'Repeat Track',
                  onPressed: () async {
                    setState(() {
                      if(!repeat) {
                        repeat = !repeat;
                        audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                      }
                      else {
                        repeat = !repeat;
                        audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.backward_end,size: 40,),
                  tooltip: 'Previous Track',
                  onPressed: () async {
                    setState(() {
                      if(id == 0) {
                        id = 29;
                        _currentIndex = id;
                      }
                      else {
                        id--;
                        _currentIndex = id;
                      }
                      position = Duration.zero;
                      setAudio();
                    });
                  },
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: shades.isNotEmpty? shades[_currentIndex].color : Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    iconSize: 55,
                    onPressed: () async {
                      if(isPlaying) {
                        await audioPlayer.pause();
                      }
                      else {
                        await audioPlayer.resume();
                        //String url = '';
                        //await audioPlayer.play(url);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.forward_end,size: 40,),
                  tooltip: 'Next Track',
                  onPressed: () async {
                    setState(() {
                      if(id == 29) {
                        id = 0;
                        _currentIndex = id;
                      }
                      else {
                        id++;
                        _currentIndex = id;
                      }
                      position = Duration.zero;
                      setAudio();
                    });
                  },

                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.smiley,size: 40,),
                  tooltip: 'Change Emotion',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CaptureImage()),
                    );
                    setState(() {
                      audioPlayer.stop();
                      position = Duration.zero;
                    });
                  },
                ),
            ]),
          ],
        ),
      ) : SpinKitWave(
        color: Colors.white,
        size: 50.0,
      )
    );
  }
}

/*Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
"Now Playing",
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,

),)]

),*/
