import 'package:guardians/track.dart';
import 'package:just_audio/just_audio.dart';

List<Track> getTrackList = [
    Track(
      title: 'Hooked on a Feeling',
      artist: 'Blue Swede',
      album: 'Awesome Mix Vol.1',
      imageUrl: 'assets/images/album1.png',
      audioUrl: 'assets/audio/hooked_on_a_feeling.mp3',
    ),
    Track(
      title: 'Come and Get Your Love',
      artist: 'Redbone',
      album: 'Awesome Mix Vol.1',
      imageUrl: 'assets/images/album1.png',
      audioUrl: 'assets/audio/come_and_get_love.mp3',
    ),
    Track(
      title: 'Cherry Bomb',
      artist: 'The Runaways',
      album: 'Awesome Mix Vol.1',
      imageUrl: 'assets/images/album1.png',
      audioUrl: 'assets/audio/cherry_bomb.mp3',
    ),
    Track(
      title: 'No Mountain High Enough',
      artist: 'Marvin Gaye e Tammi Terrell',
      album: 'Awesome Mix Vol.1',
      imageUrl: 'assets/images/album1.png',
      audioUrl: 'assets/audio/hooked_on_a_feeling.mp3',
    ),
    Track(
      title: 'Lake Shore Drive',
      artist: 'Aliotta Haynes Jeremiah',
      album: 'Awesome Mix Vol.2',
      imageUrl: 'assets/images/album2.png',
      audioUrl: 'assets/audio/lake_shore.mp3',
    ),
    Track(
      title: 'The Chain',
      artist: 'Fleetwood Mac',
      album: 'Awesome Mix Vol.2',
      imageUrl: 'assets/images/album2.png',
      audioUrl: 'assets/audio/chain.mp3',
    ),
    Track(
      title: 'Fox On The Run',
      artist: 'The Sweet',
      album: 'Awesome Mix Vol.2',
      imageUrl: 'assets/images/album2.png',
      audioUrl: 'assets/audio/fox_run.mp3',
    ),
    Track(
      title: 'Mr Blue Sky',
      artist: 'Electric Light Orchestra',
      album: 'Awesome Mix Vol.2',
      imageUrl: 'assets/images/album2.png',
      audioUrl: 'assets/audio/mr_blue.mp3',
    ),
    Track(
      title: 'Creep (Acoustic)',
      artist: 'Radiohead',
      album: 'Awesome Mix Vol.3',
      imageUrl: 'assets/images/album3.png',
      audioUrl: 'assets/audio/creep.mp3',
    ),
    // Add more tracks
  ];


  Future<Duration> _getDuration(String assetUrl) async {
  final player = AudioPlayer();
  await player.setAsset(assetUrl);
  final duration = await player.duration;
  await player.dispose();
  return duration ?? Duration.zero;
}