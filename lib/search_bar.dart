import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  static dynamic searchindex = [];
  @override
  Widget build(BuildContext context) {
    final searchcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.11,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextField(
            style: const TextStyle(fontSize: 13),
            controller: searchcontroller,
            onChanged: (String? value) {
              if (value == null || value.isEmpty) {
                temp.value.addAll(Allsongs.allsongs);
              } else {
                temp.value.clear();
                for (SongModel i in Allsongs.allsongs) {
                  if (i.title.toLowerCase().contains(value.toLowerCase())) {
                    temp.value.add(i);
                  }
                }
              }
              temp.notifyListeners();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              hintText: 'search for songs and more..',
            ),
          ),
        ),
        actions: const [
          SizedBox(width: 10,)
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: ValueListenableBuilder(
                    valueListenable: temp,
                    builder: (BuildContext ctx, List<SongModel> searchdata,
                        Widget? child) {
                      return ListView.separated(
                        separatorBuilder: ((context, index) => const Divider(
                              indent: 20,
                              endIndent: 20,
                            )),
                        itemCount: searchdata.length,
                        itemBuilder: (context, index) {
                          final data = searchdata[index];
                          return ListTile(
                            leading: QueryArtworkWidget(
                                id: data.id, type: ArtworkType.AUDIO),
                            title: Text(
                              data.title,
                              style: const TextStyle(fontSize: 15),
                            ),
                            subtitle: Text(
                              data.artist!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//   ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
//     List<AudioSource> sources = [];
//     for (var song in songs) {
//       sources.add(AudioSource.uri(Uri.parse(
//         song.uri!,
//       )));
//     }
//     return ConcatenatingAudioSource(children: sources);
//   }
// }

// indexpassing(data, index) {
//   int? searchindex;
//   for (int i = 0; i < Allsongs.allsongs.length; i++) {
//     if (data[index].id == Allsongs.allsongs[i].id) {
//       searchindex = i;
//     }
//   }
//   return searchindex;
// }
