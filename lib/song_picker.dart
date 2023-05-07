import 'package:flutter/material.dart';
import 'package:guardians/data/songs.dart';
import 'track.dart';
import 'package:guardians/music_player.dart';
import 'dart:math';
import 'package:guardians/data/backgrounds.dart';

class MusicSelectionPage extends StatefulWidget {
  const MusicSelectionPage({Key? key}) : super(key: key);

  @override
  _MusicSelectionPageState createState() => _MusicSelectionPageState();
}

class _MusicSelectionPageState extends State<MusicSelectionPage> {
  final List<Track> _allTracks = getTrackList;
  List<Track> _filteredTracks = [];
  String _searchText = "";
  String _selectedAlbum = "";

  @override
  void initState() {
    super.initState();
    _filteredTracks = _allTracks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // show search dialog or perform search action
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 30, 30),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Color.fromARGB(234, 247, 244, 244)),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchText = value.toLowerCase();
                              _filteredTracks = _allTracks
                                  .where((track) => track.title
                                      .toLowerCase()
                                      .contains(_searchText))
                                  .toList();
                              if (_selectedAlbum.isNotEmpty) {
                                _filteredTracks = _filteredTracks
                                    .where((track) =>
                                        track.album == _selectedAlbum)
                                    .toList();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    itemBuilder: (context) {
                      return getAlbumList().map((String album) {
                        return PopupMenuItem<String>(
                          value: album,
                          child: Text(album),
                        );
                      }).toList();
                    },
                    onSelected: (value) {
                      setState(() {
                        _selectedAlbum = value;
                        _filteredTracks = _allTracks
                            .where((track) => track.album == _selectedAlbum)
                            .toList();
                        if (_searchText.isNotEmpty) {
                          _filteredTracks = _filteredTracks
                              .where((track) => track.title
                                  .toLowerCase()
                                  .contains(_searchText))
                              .toList();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _searchText = "";
                        _selectedAlbum = "";
                        _filteredTracks = _allTracks;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: 200, // ajuste a altura conforme necessário
                child: ListView.separated(
                  itemCount: _filteredTracks.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final track = _filteredTracks[index];

                    // selecione uma imagem de fundo aleatória para o ListTile
                    final random = Random();
                    final randomBgIndex =
                        random.nextInt(backgroundImages.length);
                    final randomBgImage = backgroundImages[randomBgIndex];

                    return Stack(
                      children: [
                        Image.asset(
                          randomBgImage,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 500,
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height:
                              50, // reduzindo a altura da ListTile em 50 pixels
                          child: ListTile(
                            leading: Image.asset(
                              track.imageUrl,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              track.title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              track.artist,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MusicPlayer(track: track),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getAlbumList() {
    final albumSet = <String>{};
    for (var track in _allTracks) {
      albumSet.add(track.album);
    }
    return albumSet.toList();
  }
}
