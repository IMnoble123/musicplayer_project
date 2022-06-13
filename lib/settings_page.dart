

import 'package:firstproject/song_info.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';

class Forthpage extends StatelessWidget {
  const Forthpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 167, 164, 164),
      body: Column(children: [
        const SizedBox(
          height: 310,
        ),
        Center(
          child: Container(
            width: 350,
            height: 325,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: Colors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          
                        },
                        child: const Text(
                          'Add to favourites',
                          style: TextStyle(color: Colors.black87),
                        ))
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  indent: 12,
                  endIndent: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  Songsinfo(songModel: Allsongs.allsongs)));
                        },
                        child: const Text(
                          'song info',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  indent: 12,
                  endIndent: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                        
                        },
                        child: const Text(
                          'Add to playlist',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  indent: 12,
                  endIndent: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                        
                        },
                        child: const Text(
                          'play next',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  indent: 12,
                  endIndent: 10,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
