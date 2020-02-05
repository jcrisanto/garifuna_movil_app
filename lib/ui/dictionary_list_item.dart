import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/db.dart';
import 'package:garifuna_movil_app/models/word.dart';

class DictionaryListItem extends StatelessWidget {
  final Word word;
  final VoidCallback favToggled;

  DictionaryListItem(this.word, this.favToggled);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      word.def,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3F51B5)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('English: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor)),
                        Flexible(
                            child: Text(
                          word.eng,
                          softWrap: true,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Spanish: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor)),
                        Flexible(
                            child: Text(
                          word.spa,
                          softWrap: true,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Icon(
                  word.fav == 1 ? Icons.star : Icons.star_border,
                  color: Theme.of(context).accentColor,
                  size: 48.0,
                ),
                onTap: () {

                  var val = 0;

                  if(word.fav != 1) {
                      val = 1;
                  }

                  DBProvider.db.setWordFav(word.id, val).then((result) {

                      if(result == 1) {
                        word.fav = val;
                        favToggled();
                      }
                        
                  });
                  
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
