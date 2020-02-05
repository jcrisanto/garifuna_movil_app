import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/db.dart';
import 'package:garifuna_movil_app/models/word.dart';
import 'package:garifuna_movil_app/ui/dictionary_list_item.dart';

class DictionaryFragment extends StatefulWidget {
  DictionaryFragment({Key key}) : super(key: key);

  @override
  DictionaryFragmentState createState() => DictionaryFragmentState();
}

class DictionaryFragmentState extends State<DictionaryFragment> {
  List<Word> _dbWords = [];
  List<Word> _selectedWords = [];

  updateToSearchList(String search) {
    setState(() {
      _selectedWords = _dbWords
          .where((w) => w.spa.toLowerCase().startsWith(search.toLowerCase()))
          .toList();
    });
  }

  updateToFavList() {
    setState(() {
      _selectedWords = _selectedWords
          .where((w) => w.fav == 1).toList();
    });
  }

  updateToFullList() {
    setState(() {
      _selectedWords = _dbWords;
    });
  }

  @override
  void initState() {
    super.initState();
    DBProvider.db.getAllWords().then((dbws) {
      setState(() {
        _dbWords = dbws;
        updateToFullList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _selectedWords.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return DictionaryListItem(_selectedWords[index], () {
            setState(() {
              _selectedWords = _selectedWords;
            });
          });
        });
  }
}
