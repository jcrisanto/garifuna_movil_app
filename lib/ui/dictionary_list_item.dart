import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/wordDB.dart';

class DictionaryListItem extends StatelessWidget {
  final WordDb word;

  DictionaryListItem(this.word);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
              Text('• English: ',
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
              Text('• Spanish: ',
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
    );
  }
}
