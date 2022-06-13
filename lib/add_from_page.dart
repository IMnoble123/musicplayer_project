import 'package:firstproject/favrepect_ctl.dart';
import 'package:firstproject/home_page.dart';
import 'package:firstproject/play_page.dart';
import 'package:firstproject/search_bar.dart';
import 'package:firstproject/settings_page.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Addfrompage extends StatelessWidget {
  Addfrompage({Key? key}) : super(key: key);
   static AudioPlayer audioPlayer = AudioPlayer();
    final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add to favourites',
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
                      indent: 18,
                      endIndent: 18,
                    )),
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    item.data![index].displayNameWOExt,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 1,
                  ),
                  subtitle: Text(
                    "${item.data![index].artist}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Favicon(index: index,),
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
            ],
          );
        },
      ),

    );
  }
}
