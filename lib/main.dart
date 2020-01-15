import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garifuna App',
      theme: ThemeData( 
        primaryColor: Color(0xFF009688),
        primaryColorDark: Color(0xFF00796B),
        accentColor: Color(0xFFFFC107)
      ),
      home: MyHomePage(title: 'Garifuna App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
@override
  Widget build(BuildContext context) {

    List<String> options = <String>['Share Application'];
    void optionAction(String option){}
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Garifuna App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'CATEGORIES',),
              Tab(text: 'DICTIONARY')
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: optionAction,
              itemBuilder: (BuildContext context){
                  return options.map((String option){
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
              }
              
            )
          ],
        ),
        body: TabBarView(
            children: <Widget>[
              Text('Hello'),
              Text('bye')
            ],
        ),
      ),
    );
  }
}
