import 'package:flutter/material.dart';
import 'package:guardians/track.dart';
import 'landing_page.dart';
import 'music_player.dart';
import 'song_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guardians Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/player': (context) => MusicPlayer(
            track: ModalRoute.of(context)!.settings.arguments as Track),
        '/choose': (context) => const MusicSelectionPage()
      },
    );
  }
}
