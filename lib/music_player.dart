import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'track.dart';
import 'package:guardians/data/songs.dart';
import 'package:guardians/widgets/slider.dart';
import 'package:guardians/widgets/guardians_box.dart';
import 'package:guardians/data/comments.dart';
import 'dart:ui' as ui;

class MusicPlayer extends StatefulWidget {
  final Track track;

  const MusicPlayer({Key? key, required this.track}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer audioPlayer;
  int currentIndex = 0;
  List<Track> trackList = [];

 

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late StreamSubscription<Duration?> _durationSubscription;
  late StreamSubscription<Duration?> _positionSubscription;
  late ui.Image spaceshipImage;

  @override
  void initState() {
    super.initState();
    _loadSpaceshipImage();
    audioPlayer = AudioPlayer(); // initialize the audioPlayer field
    trackList = [widget.track, ...getTrackList];
    currentIndex = 0;

    _durationSubscription = audioPlayer.durationStream.listen((duration) {
      setState(() {
        this.duration = duration!;
      });
    });
    _positionSubscription = audioPlayer.positionStream.listen(_updatePosition);
      play();

  }

  Future<void> _loadSpaceshipImage() async {
    const image = AssetImage('assets/images/spaceship.png');
    final completer = Completer<ui.Image>();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, _) {
          completer.complete(info.image);
        },
      ),
    );
    spaceshipImage = await completer.future;
    setState(() {});
  }

  void _updatePosition(Duration newPosition) {
    if (mounted) {
      setState(() {
        position =
            newPosition.compareTo(duration) <= 0 ? newPosition : duration;
      });
    }
  }

  @override
  void dispose() {
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  void play() async {
    try {
      await audioPlayer.setAsset(trackList[currentIndex].audioUrl);
      setState(() {
        duration = audioPlayer.duration ?? Duration.zero;
      });
      audioPlayer.play();
    } catch (e) {
      print('Error playing track: $e');
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void next() {
    setState(() {
      currentIndex = (currentIndex + 1) % trackList.length;
    });
    play();
  }

  void prev() {
    setState(() {
      currentIndex = (currentIndex - 1 + trackList.length) % trackList.length;
    });
    play();
  }

  void playPause() {
    setState(() {
      if (audioPlayer.playing) {
        audioPlayer.pause();
      } else {
        audioPlayer.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/universe2.png"),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 156, 65, 209).withOpacity(0.9),
                  BlendMode.dstATop),
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.80),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(trackList[currentIndex].imageUrl,
                    width: 300, height: 300),
                const SizedBox(height: 20),
                Text(trackList[currentIndex].title,
                    style: const TextStyle(fontSize: 24, color: Colors.white)),
                Text(trackList[currentIndex].artist,
                    style: const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: prev,
                      iconSize: 40,
                      color: Colors.white, // Set the color of the icon
                    ),
                    IconButton(
                      icon: audioPlayer.playing
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                      onPressed: playPause,
                      iconSize: 40,
                      color: Colors.white, // Set the color of the icon
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: next,
                      iconSize: 40,
                      color: Colors.white, // Set the color of the icon
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        thumbShape: ImageSliderThumbShape(
                          image: spaceshipImage,
                          size: 100.0, // change the image size
                          positionOffset: const Offset(
                              -5, 10), // change the image position offset
                        ),
                      ),
                      child: Slider(
                        value: position.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          audioPlayer
                              .seek(Duration(milliseconds: value.toInt()));
                        },
                        min: 0.0,
                        max: duration.inMilliseconds.toDouble(),
                      ),
                    ),
                    Positioned(
                      left: 165,
                      top: 60,
                      child: Text(
                        '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                GuardiansBox(
                  title: 'Zænder',
                  image: const AssetImage('assets/images/starlord.png'),
                  text: getComment(currentIndex),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
