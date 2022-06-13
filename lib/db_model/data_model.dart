
import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class Playlistto {
  @HiveField(0)
  String? name;
  @HiveField(1)
  List<dynamic>? playlist;
  Playlistto({this.name, this.playlist = const []});
}
