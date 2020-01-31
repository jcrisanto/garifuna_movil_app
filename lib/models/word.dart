import 'dart:convert';

class Word {
    String defaultTranslation;
    String englishTranslation;
    String spanishTranslation;
    String audioPath;

    Word(this.defaultTranslation, this.englishTranslation, this.spanishTranslation, this.audioPath);

    Word.fromJSON(String data) {

      Map json = jsonDecode(data);

      defaultTranslation = json["def"];
      englishTranslation = json["eng"];
      spanishTranslation = json["spa"];
      audioPath = json["aud"];

    }

    Word.fromMap(Map json) {

      defaultTranslation = json["def"];
      englishTranslation = json["eng"];
      spanishTranslation = json["spa"];
      audioPath = json["aud"];

    }

    Map<String, dynamic> toJSON() {

      return {
        "def": defaultTranslation,
        "eng": englishTranslation,
        "spa": spanishTranslation,
        "aud": audioPath
        };

    }

    static List<Word> listFromJSON({String data, String title}){
      Map<String, dynamic> jsonData = jsonDecode(data);
      List<dynamic> jsondataList = jsonData[title];

      List<Word> words = jsondataList.map((json)=>Word.fromMap(json)).toList();

      return words;
    }
}