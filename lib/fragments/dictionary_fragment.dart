import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/db.dart';
import 'package:garifuna_movil_app/models/wordDB.dart';
import 'package:garifuna_movil_app/ui/dictionary_list_item.dart';

class DictionaryFragment extends StatefulWidget {
  
  DictionaryFragment({Key key}): super(key: key);

  @override
  DictionaryFragmentState createState() => DictionaryFragmentState();
}

class DictionaryFragmentState extends State<DictionaryFragment> {
  List<WordDb> _dbWords = [];
  List<WordDb> _selectedWords = [];

  updateList(String search) {
      setState(() {
        _selectedWords = _dbWords.where((w) => w.spa.toLowerCase().startsWith(search.toLowerCase())).toList();
      });
  }

  fillList() {
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
        fillList();
      });
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: _selectedWords.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return DictionaryListItem(_selectedWords[index]);
          });
   
  }
}