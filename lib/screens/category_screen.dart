import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/models/db.dart';
import 'package:garifuna_movil_app/models/word.dart';
import 'package:garifuna_movil_app/ui/category_list_item.dart';

class CategoryScreen extends StatefulWidget {
 
  final String title;
  final String group;
  
  const CategoryScreen(this.title, this.group);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Word> _words = [];
  
  @override
  void initState() {
    super.initState();

      DBProvider.db.getWordsByGroup(widget.group).then((dbws) {
        setState(() {
          _words = dbws;
        });
      });
   
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + ' (${_words.length})'),
        
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: _words.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return CategoryListItem(_words[index]);
          }),
    );
  }
}
