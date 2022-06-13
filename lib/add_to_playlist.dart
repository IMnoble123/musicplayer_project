import 'package:firstproject/added_playlist.dart';
import 'package:firstproject/functions/plus_functions.dart';
import 'package:firstproject/play_page.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Addtoplaylist extends StatefulWidget {
  Addtoplaylist({Key? key, this.newindex}) : super(key: key);
  int? newindex;

  @override
  State<Addtoplaylist> createState() => _AddtoplaylistState();
}

class _AddtoplaylistState extends State<Addtoplaylist> {
  @override
  Widget build(BuildContext context) {
    Functions.getdisplaylist();
    Checklist.checkindex(widget.newindex);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(Functions.listdisplay.value[widget.newindex!].name!),
        // title:const Text('Add songs',style: TextStyle(fontWeight: FontWeight.w400),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => Addedplaylist(
                          newindex: widget.newindex,
                        )));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ValueListenableBuilder(
                valueListenable: Functions.listdisplay,
                builder: (BuildContext ctx, List<dynamic> name, Widget? child) {
                  return ListView.separated(
                    separatorBuilder: ((context, index) => const Divider(
                          indent: 80,
                          endIndent: 18,
                        )),
                    itemCount: Functions
                        .listdisplay.value[widget.newindex!].playlist!.length,
                    itemBuilder: ((context, index) => ListTile(
                          title: Text(
                            Allsongs
                                .allsongs[Checklist.newlist.value[index]].title,
                            style: const TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: QueryArtworkWidget(
                              id: Allsongs
                                  .allsongs[Checklist.newlist.value[index]].id,
                              type: ArtworkType.AUDIO),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Playpage(
                                    songModel: Allsongs.allsongs,
                                    index: index)));
                          },
                          // trailing: IconButton(
                          //     onPressed: () {

                          //     },
                          //     icon: const Icon(Icons.remove)),
                        )),
                  );
                }),
          ),
          // IconButton(
          //     onPressed: () {
          //       print('here..........${functions
          //                 .listdisplay.value[widget.index!].playlist!.length}');
          //     },
          //     icon: Icon(Icons.ac_unit,color: Color.fromARGB(255, 17, 1, 1),))
        ],
      ),
    );
  }
}
