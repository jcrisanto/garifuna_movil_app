import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/fragments/categories_fragment.dart';
import 'package:garifuna_movil_app/fragments/dictionary_fragment.dart';
import 'package:garifuna_movil_app/screens/category_screen.dart';
import 'package:garifuna_movil_app/ui/fab.widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  static var appTitle = Text('Garifuna App');

  static var searchBar = TextField(
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: 'Buscar',
      hintStyle: TextStyle(color: Colors.white54),
    ),
  );

  Widget currentWidget = appTitle;
  var searchIcon = MyIcons.searchIcon;
  TabController tabController;
  Color appBarColor;

  var searchIsVisible = false;
  var fabIsVisible = false;

  
  @override
  void initState() {
    super.initState();
    appBarColor = Color(0xFF009688);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        if (tabController.index == 1) {
          appBarColor = Color(0xFF3F51B5);
          fabIsVisible = true;
          searchIsVisible = true;
        } else {
          appBarColor = Color(0xFF009688);
          fabIsVisible = false;
          searchIsVisible = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = <String>[
      'Share application',
      'Show all words',
      'Hide words'
    ];
    void optionAction(String option) {}

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: currentWidget,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'CATEGORIES',
              ),
              Tab(text: 'DICTIONARY')
            ],
          ),
          actions: <Widget>[
            Visibility(
              visible: searchIsVisible,
              child: IconButton(
                icon: Icon(searchIcon),
                onPressed: () {
                  setState(() {
                    if (searchIcon == MyIcons.searchIcon) {
                      currentWidget = searchBar;
                      searchIcon = MyIcons.cancelIcon;
                    } else {
                      currentWidget = appTitle;
                      searchIcon = MyIcons.searchIcon;
                    }
                  });
                },
              ),
            ),
            PopupMenuButton<String>(
                onSelected: optionAction,
                itemBuilder: (BuildContext context) {
                  return options.map((String option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                })
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            CategoriesFragment((title){
              Navigator.push(context, MaterialPageRoute(
                builder: (_context) => CategoryScreen(title),
              ));
            }), 
            DictionaryFragment(),
           ],
        ),
        floatingActionButton: Fab(
          isVisible: fabIsVisible,
          onPressed:(){}
          ),
      ),
    );
  }
}

class MyIcons {
  static const searchIcon = Icons.search;
  static const listIcon = Icons.format_list_bulleted;
  static const cancelIcon = Icons.cancel;
}