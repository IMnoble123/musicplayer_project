import 'dart:developer';
import 'package:firstproject/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home_page.dart';
import 'play_page.dart';
import 'songs_list_page.dart';

class Artistpage extends StatefulWidget {
  const Artistpage({Key? key}) : super(key: key);

  @override
  State<Artistpage> createState() => _ArtistpageState();
}

class _ArtistpageState extends State<Artistpage> {
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();

  playSong(String? uri) {
    try {
      Allsongs.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      Allsongs.audioPlayer.play();
    } on Exception {
      log('Error parsing song');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink.shade50,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Artists',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Search()));
              },
              icon: const Icon(Ionicons.search))
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          Allsongs.allsongs = item.data!;
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text('no songs found'));
          }
          return ListView.separated(
            separatorBuilder: ((context, index) => const Divider(
                  indent: 18,
                  endIndent: 18,
                )),
            itemBuilder: (context, index) => ListTile(
              title: Text(
                "${item.data![index].artist}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(fontSize: 15),
              ),
              // trailing: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.more_vert,
              //       color: Colors.black12,
              //     )),
              leading: QueryArtworkWidget(
                id: item.data![index].id,
                type: ArtworkType.AUDIO,
              ),
              onTap: () {
                Homepage.selectedsong = index;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Playpage(songModel: item.data!, index: index),
                  ),
                );
              },
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
