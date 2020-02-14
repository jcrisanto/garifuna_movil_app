import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/utils/prefs.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _searchValue, _speechValue;
  @override
  void initState() {
    super.initState();
    getSearchValue().then((onValue) {
      setState(() {
        _searchValue = onValue ?? 'English';
      });
    });

    getSpeechValue().then((onValue) {
      setState(() {
        _speechValue = onValue ?? 'English';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garifuna App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Search language',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 'English',
                    groupValue: _searchValue,
                    onChanged: (T) {
                      setSearchValue(T).then((_) {
                        setState(() {
                          _searchValue = T;
                        });
                      });
                    }),
                Text('English'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 'Spanish',
                    groupValue: _searchValue,
                    onChanged: (T) {
                      setSearchValue(T).then((_) {
                        setState(() {
                          _searchValue = T;
                        });
                      });
                    }),
                Text('Spanish'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 'Garifuna',
                    groupValue: _searchValue,
                    onChanged: (T) {
                      setSearchValue(T).then((_) {
                        setState(() {
                          _searchValue = T;
                        });
                      });
                    }),
                Text('Garifuna'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Speech recognition language',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 'English',
                    groupValue: _speechValue,
                    onChanged: (T) {
                      setSpeechValue(T).then((_) {
                        setState(() {
                          _speechValue = T;
                        });
                      });
                    }),
                Text('English'),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 'Spanish',
                    groupValue: _speechValue,
                    onChanged: (T) {
                      setSpeechValue(T).then((_) {
                        setState(() {
                          _speechValue = T;
                        });
                      });
                    }),
                Text('Spanish'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setSpeechValue(String v) async {
    await Prefs.getInstance().setValue(Prefs.SPEECH, v);
  }

  Future<void> setSearchValue(String v) async {
    await Prefs.getInstance().setValue(Prefs.SEARCH, v);
  }

  Future<String> getSearchValue() async {
    return Prefs.getInstance().getValue(Prefs.SEARCH);
  }

  Future<String> getSpeechValue() async {
    return Prefs.getInstance().getValue(Prefs.SPEECH);
  }
}
