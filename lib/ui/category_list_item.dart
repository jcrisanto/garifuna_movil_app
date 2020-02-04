import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/wordDB.dart';

class CategoryListItem extends StatelessWidget {
  final WordDb word;
  final AudioCache player = new AudioCache();

  CategoryListItem(this.word);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(word.eng),
                  Text(word.def, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Text(word.spa)
                ],
              ),
              GestureDetector(
                onTap: () {

                  if (word.aud != '') {
                      player.play(word.aud).whenComplete((){
                        player.clear(word.aud);
                      });
                  }
                  
                },
                child: word.aud == ''|| word.aud == null? Container() : Icon(Icons.headset, color: Theme.of(context).accentColor)
                )
            ],
          ),
        ],
      ),
    );
  }
}