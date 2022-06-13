import 'dart:developer';
import 'package:firstproject/home_page.dart';
import 'package:firstproject/search_bar.dart';
import 'package:firstproject/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'play_page.dart';

class Allsongs extends StatefulWidget {
  const Allsongs({Key? key}) : super(key: key);
  static List<SongModel> allsongs = [];
  static AudioPlayer audioPlayer = AudioPlayer();

  @override
  State<Allsongs> createState() => _AllsongsState();
}

class _AllsongsState extends State<Allsongs> {
  bool _isPlaying = false;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'On your device',
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
          return Stack(
            children: [
              ListView.separated(
                separatorBuilder: ((context, index) => const Divider(
                      indent: 60,
                      endIndent: 18,
                    )),
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    item.data![index].displayNameWOExt,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(
                    "${item.data![index].artist}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const Forthpage()));
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black87,
                      )),
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
                  onLongPress: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const Forthpage()));
                  },
                ),
                itemCount: item.data!.length,
              ),
              Positioned(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => Playpage(
                              songModel: Allsongs.allsongs,
                              index: Homepage.selectedsong)));
                    },
                    child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Playpage.audioPlayer.currentIndex != null
                            ? ListTile(
                                leading: QueryArtworkWidget(
                                    id: Allsongs
                                        .allsongs[
                                            Playpage.audioPlayer.currentIndex!]
                                        .id,
                                    type: ArtworkType.AUDIO),
                                title: Text(
                                  Allsongs
                                      .allsongs[
                                          Playpage.audioPlayer.currentIndex!]
                                      .title,
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  Allsongs
                                      .allsongs[
                                          Playpage.audioPlayer.currentIndex!]
                                      .artist
                                      .toString(),
                                  style: const TextStyle(fontSize: 10),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_isPlaying) {
                                          Playpage.audioPlayer.pause();
                                        } else {
                                          Playpage.audioPlayer.play();
                                        }
                                        _isPlaying = !_isPlaying;
                                      });
                                    },
                                    icon: Icon(
                                      _isPlaying? Icons.pause_circle_filled_outlined: Icons.play_arrow,
                                      size: 30.0,
                                    )),
                              )
                            : const Text('')),
                  ),
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
