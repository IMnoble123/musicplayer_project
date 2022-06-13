import 'dart:developer';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firstproject/favrepect_ctl.dart';
import 'package:firstproject/home_page.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class Playpage extends StatefulWidget {
  static final AudioPlayer audioPlayer = AudioPlayer();
  const Playpage({Key? key, required this.songModel, required this.index})
      : super(key: key);
  final List<SongModel> songModel;
  final dynamic index;

  @override
  State<Playpage> createState() => _PlaypageState();
}

class _PlaypageState extends State<Playpage> {
  bool _isPlaying = false;

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          Playpage.audioPlayer.positionStream,
          Playpage.audioPlayer.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();

    playSong();
  }

  void playSong() {
    try {
      Homepage.selectedsong = widget.index;
      Playpage.audioPlayer.setAudioSource(createPlaylist(widget.songModel),
          initialIndex: widget.index);
      Playpage.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log('cannot parse song');
    }
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!),
          tag: MediaItem(id: song.id.toString(), title: song.title)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

  // Future<void> onSetRepeatMode(AudioPlayer repeatMode) async{
  //   super.onSetRepeatMode(repeatMode);
  //   switch (repeatMode){

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.pink.shade50,
      //   elevation: 0,
      //   leading: IconButton(onPressed: (){}, icon:const Icon(Icons.roofing_outlined) ),
      //   title: Text( widget.songModel[Playpage.audioPlayer.currentIndex!]
      //                         .title,
      //                     overflow: TextOverflow.ellipsis,
      //                     maxLines: 1,
      //                     style: const TextStyle(
      //                         fontSize: 16, fontWeight: FontWeight.bold),),
      //                         actions: [
      //                                   Text(
      //                       widget.songModel[Playpage.audioPlayer.currentIndex!]
      //                                   .artist
      //                                   .toString() ==
      //                               "<unknown>"
      //                           ? "unknown Artist"
      //                           : widget
      //                               .songModel[
      //                                   Playpage.audioPlayer.currentIndex!]
      //                               .artist
      //                               .toString(),
      //                       overflow: TextOverflow.fade,
      //                       maxLines: 1,
      //                       style: const TextStyle(
      //                         fontSize: 12,
      //                       ))
      //                         ],

      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: const [Icon(Icons.volume_up)],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: QueryArtworkWidget(
                              artworkBorder: BorderRadius.circular(500),
                              id: widget
                                  .songModel[Playpage.audioPlayer.currentIndex!]
                                  .id,
                              type: ArtworkType.AUDIO),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.songModel[Playpage.audioPlayer.currentIndex!]
                              .title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        Text(
                            widget.songModel[Playpage.audioPlayer.currentIndex!]
                                        .artist
                                        .toString() ==
                                    "<unknown>"
                                ? "unknown Artist"
                                : widget
                                    .songModel[
                                        Playpage.audioPlayer.currentIndex!]
                                    .artist
                                    .toString(),
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                      context: context,
                                      builder: (ctx) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading:  Favicon(index: widget.index),
                                              title: const Text(' Add to favourites'),
                                            ),
                                             ListTile(
                                              leading: const Icon(Icons.playlist_add),
                                              title:const Text('Add to playlist'),
                                              onTap: (){

                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.add)),
                            const SizedBox(
                              width: 5,
                            ),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.more_vert))
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 15),
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(bottom: 4.0),
                            child: StreamBuilder<DurationState>(
                              stream: _durationStateStream,
                              builder: (context, snapshot) {
                                final durationState = snapshot.data;
                                final progress =
                                    durationState?.position ?? Duration.zero;
                                final total =
                                    durationState?.total ?? Duration.zero;
                                return ProgressBar(
                                  thumbRadius: 6,
                                  progress: progress,
                                  total: total,
                                  barHeight: 4.0,
                                  progressBarColor:
                                      const Color.fromARGB(236, 63, 63, 63),
                                  thumbColor: Colors.black,
                                  onSeek: (duration) {
                                    Playpage.audioPlayer.seek(duration);
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: InkWell(
                              onTap: () {
                                Playpage.audioPlayer.loopMode == LoopMode.one
                                    ? Playpage.audioPlayer
                                        .setLoopMode(LoopMode.all)
                                    : Playpage.audioPlayer
                                        .setLoopMode(LoopMode.one);
                                // toast(context, "repect crnt song");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: StreamBuilder<LoopMode>(
                                    stream: Playpage.audioPlayer.loopModeStream,
                                    builder: (context, snapshot) {
                                      final loopMode = snapshot.data;
                                      if (LoopMode.one == loopMode) {
                                        return const Icon(
                                          Icons.repeat_one,
                                          color: Colors.black,
                                        );
                                      }
                                      return const Icon(
                                        Icons.repeat,
                                        color: Colors.black,
                                      );
                                    }),
                              ),
                            )),
                            IconButton(
                                onPressed: () {
                                  if (Playpage.audioPlayer.hasPrevious) {
                                    Playpage.audioPlayer.seekToPrevious();
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous,
                                  size: 30.0,
                                )),
                            IconButton(
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
                                  _isPlaying
                                      ? Icons.pause_circle_filled_outlined
                                      : Icons.play_arrow,
                                  size: 39.0,
                                )),
                            IconButton(
                                onPressed: () async {
                                  if (Playpage.audioPlayer.hasNext) {
                                    await Playpage.audioPlayer.seekToNext();
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next,
                                  size: 30.0,
                                )),
                            Favicon(index: widget.index)
                          ],
                        ),
                        // Flexible(
                        //     child: InkWell(
                        //   onTap: () {
                        //     Playpage.audioPlayer.setShuffleModeEnabled(true);
                        //     toast(context, "Shufflle enabled");
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.all(10.0),
                        //     margin: const EdgeInsets.only(right: 30.0, left: 30.0),
                        //     child: const Icon(
                        //       Icons.shuffle,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
