// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:firstproject/play_page.dart';
// import 'package:firstproject/songs_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:rxdart/rxdart.dart';

// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({Key? key}) : super(key: key);

//   @override
//   _MiniPlayerState createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
//   bool _isPlaying = false;

//   Stream<DurationState> get _durationStateStream =>
//       Rx.combineLatest2<Duration, Duration?, DurationState>(
//         Playpage.audioPlayer.positionStream,
//         Playpage.audioPlayer.durationStream,
//         (position, duration) =>
//             DurationState(position: position, total: duration ?? Duration.zero),
//       );

//   // AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final bool rotated = MediaQuery.of(context).size.height < screenWidth;
//     return StreamBuilder<PlaybackState>(
//       stream: audioHandler.playbackState,
//       builder: (context, snapshot) {
//         final playbackState = snapshot.data;
//         final processingState = playbackState?.processingState;
//         if (processingState == AudioProcessingState.idle) {
//           return const SizedBox();
//         }
//         return StreamBuilder<MediaItem?>(
//           stream: audioHandler.mediaItem,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.active) {
//               return const SizedBox();
//             }
//             final mediaItem = snapshot.data;
//             if (mediaItem == null) return const SizedBox();
//             return Dismissible(
//               key: const Key('miniplayer'),
//               direction: DismissDirection.down,
//               onDismissed: (_) {
//                 Feedback.forLongPress(context);
//                 audioHandler.stop();
//               },
//               child: Dismissible(
//                 key: Key(mediaItem.id),
//                 confirmDismiss: (DismissDirection direction) {
//                   if (direction == DismissDirection.startToEnd) {
//                     audioHandler.skipToPrevious();
//                   } else {
//                     audioHandler.skipToNext();
//                   }
//                   return Future.value(false);
//                 },
//                 child: ValueListenableBuilder(
//                   valueListenable: Hive.box('settings').listenable(),
//                   child: StreamBuilder<DurationState>(
//                    stream: _durationStateStream,
//                   builder: (context, snapshot) {
//                     final durationState = snapshot.data;
//                     final progress = durationState?.position ?? Duration.zero;
//                     final total = durationState?.total ?? Duration.zero;
//                     return ProgressBar(
//                       thumbRadius: 6,
//                       progress: progress,
//                       total: total,
//                       barHeight: 5.0,
//                       progressBarColor: const Color.fromARGB(236, 63, 63, 63),
//                       thumbColor: Colors.black,
//                       onSeek: (duration) {
//                         Playpage.audioPlayer.seek(duration);
//                       },
//                     );
                  
//                   },
//                   ),
//                   builder: (BuildContext context, Box box1, Widget? child) {
//                     final bool useDense = box1.get(
//                           'useDenseMini',
//                           defaultValue: false,
//                         ) as bool ||
//                         rotated;
//                     final List preferredMiniButtons = Hive.box('settings').get(
//                       'preferredMiniButtons',
//                       defaultValue: ['Previous', 'Play/Pause', 'Next'],
//                     )?.toList() as List;

//                     return Card(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 2.0,
//                         vertical: 1.0,
//                       ),
//                       child: SizedBox(
//                         height: useDense ? 68.0 : 76.0,
//                         child: Container(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               ListTile(
//                                 dense: useDense,
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     PageRouteBuilder(
//                                       opaque: false,
//                                       pageBuilder: (_, __, ___) =>
//                                        Playpage(songModel: Allsongs.allsongs, index: )
//                                     ),
//                                   );
//                                 },
//                                   leading: QueryArtworkWidget(
//                 id: item.data![index].id,
//                 type: ArtworkType.AUDIO,
//               ),
                      
//                                 title: Text(
//                                   mediaItem.title,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 subtitle: Text(
//                                   mediaItem.artist ?? '',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 // leading: Hero(
//                                 //   tag: 'currentArtwork',
//                                 //   child: Card(
//                                 //     elevation: 8,
//                                 //     shape: RoundedRectangleBorder(
//                                 //       borderRadius: BorderRadius.circular(7.0),
//                                 //     ),
//                                 //     clipBehavior: Clip.antiAlias,
//                                 //     child: (
//                                 //       mediaItem.artUri
//                                 //             .toString()
//                                 //             .startsWith('file:'))
//                                 //         ? SizedBox.square(
//                                 //             dimension: useDense ? 40.0 : 50.0,
//                                 //             child: Image(
//                                 //               fit: BoxFit.cover,
//                                 //               image: FileImage(
//                                 //                 File(
//                                 //                   mediaItem.artUri!
//                                 //                       .toFilePath(),
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           )
//                                 //         : SizedBox.square(
//                                 //             dimension: useDense ? 40.0 : 50.0,
//                                 //             child: CachedNetworkImage(
//                                 //               fit: BoxFit.cover,
//                                 //               errorWidget: (
//                                 //                 BuildContext context,
//                                 //                 _,
//                                 //                 __,
//                                 //               ) =>
//                                 //                   const Image(
//                                 //                 fit: BoxFit.cover,
//                                 //                 image: AssetImage(
//                                 //                   'assets/cover.jpg',
//                                 //                 ),
//                                 //               ),
//                                 //               placeholder: (
//                                 //                 BuildContext context,
//                                 //                 _,
//                                 //               ) =>
//                                 //                   const Image(
//                                 //                 fit: BoxFit.cover,
//                                 //                 image: AssetImage(
//                                 //                   'assets/cover.jpg',
//                                 //                 ),
//                                 //               ),
//                                 //               imageUrl:
//                                 //                   mediaItem.artUri.toString(),
//                                 //             ),
//                                 //           ),
//                                 //   ),
//                                 ),
//                                 trailing: Buttons(
//                                   audioHandler,
//                                   miniplayer: true,
//                                   buttons: mediaItem.artUri
//                                           .toString()
//                                           .startsWith('file:')
//                                       ? ['Previous', 'Play/Pause', 'Next']
//                                       : preferredMiniButtons,
//                                 ),
//                               ),
//                               child!,
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
// class DurationState {
//   DurationState({this.position = Duration.zero, this.total = Duration.zero});
//   Duration position, total;
// }
