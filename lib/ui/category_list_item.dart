import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/word.dart';

class CategoryListItem extends StatelessWidget {
  final Word word;
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(word.eng, softWrap: true),
                    Text(
                      word.def,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(word.spa, softWrap: true)
                  ],
                ),
              ),
              Visibility(
                visible: word.aud != '' && word.aud != null,
                child: InkWell(
                    onTap: () {
                      if (word.aud != '') {
                        player.play(word.aud).whenComplete(() {
                          player.clear(word.aud);
                          player.clearCache();
                        });
                      }
                    },
                    child: Icon(Icons.headset,
                        size: 48.0, color: Theme.of(context).accentColor)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
