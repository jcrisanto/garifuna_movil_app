import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/word.dart';

class CategoryListItem extends StatelessWidget {
  final Word word;
  CategoryListItem(this.word);
  AudioCache player = new AudioCache();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(word.englishTranslation),
                Text(word.defaultTranslation, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                Text(word.spanishTranslation)
              ],
            ),
            GestureDetector(
              onTap: () {

                
                player.play(word.audioPath).whenComplete((){
                  player.clear(word.audioPath);
                });
                
              },
              child: Icon(Icons.speaker, color: Theme.of(context).accentColor)
              )
          ],
        ),
        Divider(
              color: Theme.of(context).primaryColor,
            )
      ],
    );
  }
}