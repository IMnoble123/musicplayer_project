import 'package:firstproject/functions/plus_functions.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/material.dart';


class Favicon extends StatefulWidget {
  Favicon({Key? key, this.index}) : super(key: key);

  dynamic index;

  @override
  State<Favicon> createState() => _FaviconState();
}

class _FaviconState extends State<Favicon> {

void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }



  @override
  Widget build(BuildContext context) {
    final findindex = Functions.favsong.value.contains(widget.index);
    final indexcheck = Functions. dblist.indexWhere((element) => element == Allsongs.allsongs[widget.index] .id);
    if (findindex == true) {
      return IconButton(
          onPressed: () async { 
            Functions.delectsong(indexcheck);
            // toast(context, " Removed from favorites");
            setState(() {});
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ));
    }
    return IconButton(
        onPressed: () async {
         await Functions.addfavsong(Allsongs.allsongs[widget.index].id);
           toast(context, "Add to favorites");
          setState(() {});
        },
        icon: const Icon(Icons.favorite_border, color: Color.fromARGB(96, 69, 68, 68)));
        
      
  }
}
