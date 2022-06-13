import 'package:firstproject/db_model/data_model.dart';
import 'package:firstproject/functions/plus_functions.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';

class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.songindex})
      : super(key: key);
  int? index;
  int? folderindex;
  int? songindex;
  List<dynamic> songslist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
    final checkindex = Functions
        .listdisplay.value[widget.folderindex!].playlist!
        .contains(widget.songindex);
    final indexcheck =
        Functions.listdisplay.value[widget.folderindex!].playlist!.indexWhere(
            (element) => element == Allsongs.allsongs[widget.index!].id);
    if (checkindex != true) {
      return IconButton(
          onPressed: () async {
            widget.songslist.add(Allsongs.allsongs[widget.index!].id);
            PlaylistButton.updatelist = [
              widget.songslist,
              Functions.listdisplay.value[widget.folderindex!].playlist!
            ].expand((element) => element).toList();
            final model = Playlistto(
              name: Functions.listdisplay.value[widget.folderindex!].name,
              playlist: PlaylistButton.updatelist,
            );
            Functions.updatelist(widget.folderindex, model);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ' Song added to playlist ${Functions.listdisplay.value[widget.folderindex!].name},',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.add, color: Colors.black));
    }
    return IconButton(
        onPressed: () async {
          Functions.listdisplay.value[widget.folderindex!].playlist!
              .removeAt(indexcheck);
          PlaylistButton.dltlist = [
            widget.songslist,
            Functions.listdisplay.value[widget.folderindex!].playlist!
          ].expand((element) => element).toList();
          final model = Playlistto(
            name: Functions.listdisplay.value[widget.folderindex!].name,
            playlist: PlaylistButton.dltlist,
          );

          Functions.updatelist(widget.folderindex, model);
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Song deleted from the playlist  ${Functions.listdisplay.value[widget.folderindex!].name},',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromARGB(255, 68, 68, 68),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: Icon(
          Icons.remove,
          color: Colors.red.shade200,
        ));
  }
}
