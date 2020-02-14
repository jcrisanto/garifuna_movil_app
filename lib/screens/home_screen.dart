import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/fragments/categories_fragment.dart';
import 'package:garifuna_movil_app/fragments/dictionary_fragment.dart';
import 'package:garifuna_movil_app/screens/category_screen.dart';
import 'package:garifuna_movil_app/screens/settings_screen.dart';
import 'package:garifuna_movil_app/ui/fab.widget.dart';
import 'package:garifuna_movil_app/ui/my_text_field.dart';
import 'package:garifuna_movil_app/utils/prefs.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<DictionaryFragmentState> _myWidgetState =
      GlobalKey<DictionaryFragmentState>();
  Text appTitle;
  String search = '';
  TextEditingController searchController;
  TextField searchBar;
  Widget appBarWidget;
  IconData searchIcon = SearchIcon.search;
  TabController tabController;
  Color appBarColor;
  IconData favIcon;
  IconData fabIcon;
  bool searchIsVisible = false;
  bool fabIsVisible = false;
  bool favIsVisible = false;
  bool menuIsVisible = true;
  SpeechToText _speech;
  String searchHintText;

  @override
  void initState() {
    super.initState();
    initSpeech();
    appTitle = Text(widget.title);
    searchController = TextEditingController();
    searchBar = TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: searchHintText,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      controller: searchController,
    );
    appBarWidget = appTitle;

    appBarColor = Color(0xFF009688);
    tabController = TabController(length: 2, vsync: this);
    favIcon = FavIcon.empty;
    tabController.addListener(() {
      setState(() {
        if (tabController.index == 1) {
          appBarColor = Color(0xFF3F51B5);
          fabIsVisible = true;
          searchIsVisible = true;
          favIsVisible = true;
          favIcon = FavIcon.empty;
        } else {
          appBarColor = Color(0xFF009688);
          fabIsVisible = false;
          searchIsVisible = false;
          appBarWidget = appTitle;
          searchIcon = SearchIcon.search;
          favIsVisible = false;
        }
      });
    });
    searchController.addListener(() {
      _myWidgetState.currentState.updateToSearchList(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = <String>['Share application', 'Settings'];
    void optionAction(String option) {
      switch (option) {
        case 'Settings':
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_context) => SettingsScreen(),
              ));
          break;
        default:
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: appBarWidget,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: 'CATEGORIES',
              ),
              Tab(text: 'DICTIONARY'),
            ],
          ),
          actions: <Widget>[
            Visibility(
              visible: searchIsVisible,
              child: IconButton(
                icon: Icon(searchIcon),
                onPressed: () {
                  setState(() {
                    if (searchIcon == SearchIcon.search) {
                      Prefs.getInstance().getValue(Prefs.SEARCH).then((lang) {
                        this._myWidgetState.currentState.updateLang(lang ?? 'English');
                        setState(() {
                          appBarWidget = JCTextField(
                              hintText: 'Buscar (${lang ?? 'English'})',
                              controller: searchController);
                        });
                      });

                      searchIcon = SearchIcon.cancel;
                      favIcon = FavIcon.empty;
                      favIsVisible = false;
                      fabIsVisible = false;
                      fabIsVisible = false;
                      menuIsVisible = false;
                    } else {
                      appBarWidget = appTitle;
                      searchIcon = SearchIcon.search;
                      searchController.text = '';
                      _myWidgetState.currentState.updateToFullList();
                      favIsVisible = true;
                      fabIsVisible = true;
                      menuIsVisible = true;
                    }
                  });
                },
              ),
            ),
            Visibility(
              visible: favIsVisible,
              child: IconButton(
                  icon: Icon(favIcon),
                  onPressed: () {
                    _myWidgetState.currentState.updateToFavList();
                    if (favIcon == FavIcon.empty) {
                      setState(() {
                        favIcon = FavIcon.full;
                      });
                      _myWidgetState.currentState.updateToFavList();
                    } else {
                      setState(() {
                        favIcon = FavIcon.empty;
                      });
                      _myWidgetState.currentState.updateToFullList();
                    }
                  }),
            ),
            Visibility(
              visible: menuIsVisible,
              child: PopupMenuButton<String>(
                  onSelected: optionAction,
                  itemBuilder: (BuildContext context) {
                    return options.map((String option) {
                      return PopupMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList();
                  }),
            )
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
            DictionaryFragment(key: _myWidgetState)
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Fab(
            isVisible: fabIsVisible,
            icon: fabIcon,
            onPressed: () {
              if (fabIcon == FabIcon.close) {
                _myWidgetState.currentState.updateToFullList();
                setState(() {
                  searchIsVisible = true;
                  favIsVisible = true;
                  fabIcon = FabIcon.open;
                  appBarWidget = appTitle;
                });
              } else if (fabIcon == FabIcon.open) {
                if (_speech.isAvailable && !_speech.isListening) {
                  setState(() {
                    appBarWidget = Text('Listening...',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontStyle: FontStyle.italic));
                    searchIsVisible = false;
                    favIsVisible = false;
                    fabIcon = FabIcon.active;
                  });
                  _speech.listen(onResult: (result) {
                    appBarWidget =
                        Text(firstCapNoPeriod(_speech.lastRecognizedWords));
                    _myWidgetState.currentState
                        .updateToSearchList(_speech.lastRecognizedWords);
                    if (result.finalResult) {
                      _speech.cancel();
                      setState(() {
                        fabIcon = FabIcon.close;
                      });
                    }
                  });
                } else {}
              }
            }),
      ),
    );
  }

  initSpeech() async {
    setState(() {
      fabIcon = FabIcon.open;
    });
    _speech = SpeechToText();
    await _speech.initialize(onError: onSpeechErrorHandler);
  }

  onSpeechErrorHandler(SpeechRecognitionError error) {
    _speech.cancel();
    initSpeech();
    setState(() {
      appBarWidget = appTitle;
    });
  }
}

class SearchIcon {
  static const search = Icons.search;
  static const cancel = Icons.cancel;
}

class FavIcon {
  static const full = Icons.star;
  static const empty = Icons.star_border;
}

class FabIcon {
  static const open = Icons.mic;
  static const active = Icons.blur_on;
  static const close = Icons.close;
}

String firstCapNoPeriod(String text) {
  String holder = '';
  holder = text.replaceFirst(text[0], text[0].toUpperCase());
  holder = holder.replaceAll('.', '');
  return holder;
}
