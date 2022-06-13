import 'package:firstproject/db_model/data_model.dart';
import 'package:firstproject/songs_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Functions {
  static ValueNotifier<List> favsong = ValueNotifier([]);
  static var dblist = [];

  static addfavsong(value) async {
    final songsDB = await Hive.openBox('song_db');
    await songsDB.add(value);
    dblist=songsDB.values.toList();
    // print('........................noble....${songsDB}');//
    Functions.favsong.value.add(value);
    showlistfavsongs();
   
  }

  static showlistfavsongs() async {
    final songsDB = await Hive.openBox('song_db');
    final dbsongs = songsDB.values.toList();
    favsong.value.clear();
    for (int i = 0; i < dbsongs.length; i++) {
      for (int j = 0; j < Allsongs.allsongs.length; j++) {
        if (dbsongs[i] == Allsongs.allsongs[j].id) {
          favsong.value.add(j);
        }
      }
    }
    favsong.notifyListeners();
  }

  static delectsong(index) async {
    final songsDB = await Hive.openBox('song_db');
    await songsDB.deleteAt(index);
    showlistfavsongs();
  }


  // function for Playlist //


  static addplaylist({required Playlistto model}) async {
    final Playlistdb = await Hive.openBox<Playlistto>('_addplay');
    await Playlistdb.add(model);
    // print('..${Playlistdb.values}');//
    getdisplaylist();
  }

  static ValueNotifier<List<Playlistto>> listdisplay = ValueNotifier([]);

  static getdisplaylist() async {
    final Playlistdb = await Hive.openBox<Playlistto>('_addplay');
    listdisplay.value.clear();
    // database values to list
    listdisplay.value.addAll(Playlistdb.values);
    listdisplay.notifyListeners();
  }

  static updatelist(index, model) async {
    final Playlistdb = await Hive.openBox<Playlistto>('_addplay');
    Playlistdb.putAt(index, model);
    getdisplaylist();
    Checklist.checkindex(index);
  }

  static deleteplaylist(index) async {
    final Playlistdb = await Hive.openBox<Playlistto>('_addplay');
    await Playlistdb.deleteAt(index);
    getdisplaylist();
  }
}

class Checklist {
  static ValueNotifier<List<int>> newlist = ValueNotifier([]);
  static checkindex(index) async {
    List fullist = Functions.listdisplay.value[index].playlist!;
    newlist.value.clear();
    for (int i = 0; i < fullist.length; i++) {
      for (var j = 0; j < Allsongs.allsongs.length; j++) {
        if (fullist[i] == Allsongs.allsongs[j].id) {
          newlist.value.add(j);
        }
      }
    }
  }



}
