import 'package:flutter/material.dart';

import '../common/global.dart';


Map<String, Object> blankSentence() {
  return {
            "tags":[],
            "tense": "",
            "form": [],
            "synonym": [],
            "antonym": [],
            "pattern": ["", ""],
          };
}

class Store extends ChangeNotifier {
  List<bool> onOffWidget = [true, true, true];
  List<String> get partOfSpeechOptions => Global.partOfSpeechOptions;
  List<String> get wordTagOptions => Global.wordTagOptions;
  List<String> etyma = []; // 词根词缀 ["dis", "ion", "er", "or", "pre", "un"],
  List<String> morph = []; // 单词变型
  List<String> synonym = []; // 近义词
  List<String> antonym = []; // 反义词
  updateUI(){
    notifyListeners();
  }
}
