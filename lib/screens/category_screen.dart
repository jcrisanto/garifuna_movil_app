import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garifuna_movil_app/models/word.dart';
import 'package:garifuna_movil_app/ui/category_list_item.dart';

class CategoryScreen extends StatefulWidget {
 
  final String title;
  List<Word> words;
  CategoryScreen(this.title);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    super.initState();
    loadWordsAsset().then( (json) {
      setState(() {
        widget.words = Word.listFromJSON(data: json, title: widget.title);
      });
      
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: widget.words.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return CategoryListItem(widget.words[index]);
          }),
    );
  }
}

Future<String> loadWordsAsset() async {
  return await rootBundle.loadString('assets/words.json');
}
