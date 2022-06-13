import 'package:firstproject/add_from_page.dart';
import 'package:firstproject/functions/plus_functions.dart';
import 'package:firstproject/play_page.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favpage extends StatelessWidget {
  const Favpage({Key? key}) : super(key: key);

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Functions.showlistfavsongs();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favourites',
          style: TextStyle( fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Addfrompage()));
              },
              icon: const Icon(Icons.add))
        ],
        backgroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
          valueListenable: Functions.favsong,
          builder: (BuildContext ctx, List<dynamic> indexs, Widget? child) {
            return ListView.separated(
              separatorBuilder: ((context, index) => const Divider(
                    indent: 18,
                    endIndent: 18,
                  )),
              itemCount: Functions.favsong.value.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: QueryArtworkWidget(
                      id: Allsongs.allsongs[indexs[index]].id,
                      type: ArtworkType.AUDIO),
                  title: Text(Allsongs.allsongs[indexs[index]].title,
                      overflow: TextOverflow.ellipsis),
                  subtitle: Text(Allsongs.allsongs[indexs[index]].artist!,
                      overflow: TextOverflow.fade),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Playpage(
                            songModel: Allsongs.allsongs,
                            index: indexs[index])));
                  },
                  trailing: IconButton( 
                      onPressed: () async {
                        await Functions.delectsong(index);
                        toast(context, " Removed from favorites");
                      },
                      icon: const Icon(
                        Ionicons.heart,
                        size: 18,
                        color: Colors.red,
                      )),
                );
              },
            );
          }),
    );
  }
}
