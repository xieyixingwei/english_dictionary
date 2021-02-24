import 'package:flutter/material.dart';
import '../common/global.dart';


class MiscModel extends ChangeNotifier {
  List<bool> get onOffWidget => Global.onOffWidget;
  List<String> get wordTagOptions => Global.wordTagOptions;
  List<String> get sentenceTagOptions => Global.sentenceTagOptions;

  updateUI(){
    notifyListeners();
  }
}
