import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/fragments/categories_fragment.dart';
import 'package:garifuna_movil_app/fragments/dictionary_fragment.dart';
import 'package:garifuna_movil_app/screens/category_screen.dart';
import 'package:garifuna_movil_app/ui/fab.widget.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Text appTitle;
  String search = '';
  TextEditingController searchController;
  TextField searchBar;
  Widget currentWidget;
  var searchIcon = MyIcons.searchIcon;
  TabController tabController;
  Color appBarColor;
  IconData favToggle;
  var searchIsVisible = false;
  var fabIsVisible = false;
  bool favIsVisible = false;
  final GlobalKey<DictionaryFragmentState> _myWidgetState =
      GlobalKey<DictionaryFragmentState>();

  @override
  void initState() {
    super.initState();
    appTitle = Text(widget.title);
    searchController = TextEditingController();
    searchBar = TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Buscar',
        hintStyle: TextStyle(color: Colors.white54),
      ),
      controller: searchController,
    );
    currentWidget = appTitle;

    appBarColor = Color(0xFF009688);
    tabController = TabController(length: 2, vsync: this);
    favToggle = Icons.star_border;
    tabController.addListener(() {
      setState(() {
        if (tabController.index == 1) {
          appBarColor = Color(0xFF3F51B5);
          fabIsVisible = true;
          searchIsVisible = true;
          favIsVisible = true;
        } else {
          appBarColor = Color(0xFF009688);
          fabIsVisible = false;
          searchIsVisible = false;
          currentWidget = appTitle;
          searchIcon = MyIcons.searchIcon;
        }
      });
    });
    searchController.addListener(() {
      _myWidgetState.currentState.updateToSearchList(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = <String>['Share application'];
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
                      favToggle = Icons.star_border;
                      favIsVisible = false;
                    } else {
                      currentWidget = appTitle;
                      searchIcon = MyIcons.searchIcon;
                      searchController.text = '';
                      _myWidgetState.currentState.updateToFullList();
                      favIsVisible = true;
                    }
                  });
                },
              ),
            ),
            Visibility(
              visible: favIsVisible,
              child: IconButton(
                  icon: Icon(favToggle),
                  onPressed: () {
                    _myWidgetState.currentState.updateToFavList();
                    if (favToggle == Icons.star_border) {
                      setState(() {
                        favToggle = Icons.star;
                      });
                      _myWidgetState.currentState.updateToFavList();
                    } else {
                      setState(() {
                        favToggle = Icons.star_border;
                      });
                      _myWidgetState.currentState.updateToFullList();
                    }
                  }),
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
            CategoriesFragment((title, group) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_context) => CategoryScreen(title, group),
                  ));
            }),
            DictionaryFragment(key: _myWidgetState),
          ],
        ),
        floatingActionButton: Fab(isVisible: fabIsVisible, onPressed: () {}),
      ),
    );
  }
}

class MyIcons {
  static const searchIcon = Icons.search;
  static const listIcon = Icons.format_list_bulleted;
  static const cancelIcon = Icons.cancel;
}
