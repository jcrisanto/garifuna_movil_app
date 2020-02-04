import 'package:flutter/material.dart';

class WordDb {
    int id;
    String def;
    String eng;
    String spa;
    String aud;
    String grp;
    int fav;

    WordDb({this.id, @required this.def, @required this.eng, @required this.spa, this.aud, this.grp, this.fav});

    WordDb.fromMap(Map map) {
      id = map['id'];
      def = map['def'];
      eng = map['eng'];
      spa = map['spa'];
      aud = map['aud'];
      grp = map['grp'];
      fav = map['fav'];
    }

    Map<String, dynamic> toMap() => {
      'id' : id,
      'def' : def,
      'eng' : eng,
      'spa': spa,
      'aud' : aud,
      'group' : grp,
      'fav' : fav
    };

}