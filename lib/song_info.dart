import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songsinfo extends StatefulWidget {
  const Songsinfo({Key? key, required this.songModel}) : super(key: key);
  final List<SongModel> songModel;

  @override
  State<Songsinfo> createState() => _SongsinfoState();
}

class _SongsinfoState extends State<Songsinfo> {
  // final _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Song info'),
        elevation: 0,
        backgroundColor: Colors.pink.shade50,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: []),
      ),
    );
  }
}
