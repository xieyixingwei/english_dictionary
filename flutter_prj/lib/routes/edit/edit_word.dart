import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/ItemEdit.dart';
import 'package:flutter_prj/states/word_state.dart';
import 'package:flutter_prj/widgets/DeletableDropdownButton.dart';
import 'package:flutter_prj/widgets/InputTag.dart';
import 'package:flutter_prj/widgets/OnOffWidget.dart';
import 'package:flutter_prj/widgets/SelectTag.dart';
import 'package:provider/provider.dart';
import '../../states/store.dart';
import 'ItemsEdit.dart';


class EditWord extends StatelessWidget {
  final _textStyle = const TextStyle(fontSize: 14,);
  final wName = TextEditingController();
  final wVoiceUs = TextEditingController();
  final wVoiceUk = TextEditingController();
  final wOrigin = TextEditingController();
  final wShorthand = TextEditingController();

  _buildRow1(BuildContext context, WordState word) {
    wName.text = word.word.w_name;
    wVoiceUs.text = word.word.w_voice_us;
    wVoiceUk.text = word.word.w_voice_uk;

    return Row(
      children: [
        Expanded(
          flex: 10,
          child: TextField(
            controller: wName,
            style: _textStyle,
            decoration: InputDecoration(
              hintText: "单词",
              suffixIcon: InkWell(
                child: Icon(Icons.search,),
                onTap: () { print("--- 搜索单词 ${word.word.w_name}"); },
              ),
            ),
            onChanged: (String value) => word.word.w_name = value,
          ),
        ),
        Expanded(flex: 1, child: Container(width:0, height:0),),
        Expanded(
          flex: 5,
          child: TextField(
            controller: wVoiceUs,
            style: _textStyle,
            decoration: InputDecoration(
              hintText: "音标(美)",
            ),
            onChanged: (String value) => word.word.w_voice_us = value,
          ),
        ),
        Expanded(flex:1, child: Container(width:0, height:0),),
        Expanded(
          flex: 5,
          child:TextField(
            controller: wVoiceUk,
            style: _textStyle,
            decoration: InputDecoration(
              hintText: "音标(英)",
            ),
            onChanged: (String value) => word.word.w_voice_uk = value,
          ),
        ),
      ],
    );
  }
  _padding(Widget child) =>
    Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: child,
    );

  _buildRow2(BuildContext context, WordState word, Store store) {
    wOrigin.text = word.word.w_origin;
    wShorthand.text = word.word.w_shorthand;
    return OnOffWidget(
      label: "详情",
      hide: store.onOffWidget[0],
      click: (bool status) {store.onOffWidget[0] = !status; store.updateUI();},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _padding(
            SelectTag(
              data: word.word.w_tags,
              options: store.wordTagOptions,
              tooltip: "添加Tag",
              lable: "Tag:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { word.word.w_tags.add(value); word.notifyListeners();},
              delete: (String value) { word.word.w_tags.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            InputTag(
              data: word.word.w_etyma,
              tooltip: "输入词根词缀",
              lable: "词根词缀:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { word.word.w_etyma.add(value); word.notifyListeners();},
              delete: (String value) { word.word.w_etyma.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            InputTag(
              data: word.word.w_morph,
              tooltip: "输入变型单词",
              lable: "变型单词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { word.word.w_morph.add(value); word.notifyListeners();},
              delete: (String value) { word.word.w_morph.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            TextField(
              controller: wOrigin,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                labelText: "词源",
                hintText: "输入词源(markdown)",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                word.word.w_origin = value;
              },
            )
          ),
          _padding(
            TextField(
              controller: wShorthand,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                labelText: "速记",
                hintText: "输入速记(markdown)",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                word.word.w_shorthand = value;
              },
            )
          ),
        ],
      ),
    );
  }

  _buildRow3(BuildContext context, WordState word, Store store) {
    List<Widget> children = [];

    var delete = (Object that) {
      word.word.w_partofspeech.remove(that);
      Provider.of<Store>(context, listen:false).updateUI();
    };

    word.word.w_partofspeech.forEach((val){
      var index = word.word.w_partofspeech.indexOf(val) + 1;
      children.add(OnePartOfSpeech(data:val, index:index, delete:delete, options:store.partOfSpeechOptions));
    });

    children.add(
      Padding(
        padding: EdgeInsets.fromLTRB(20,0,0,20),
        child: IconButton(
          icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
          padding: EdgeInsets.zero,
          tooltip: "添加释义",
          splashRadius:1,
          onPressed: () {
            word.word.w_partofspeech.add(
              {
                "type":"",
                "items":[]
              }
            );
            Provider.of<Store>(context, listen:false).updateUI();
          },
        ),
      )
    );
    return OnOffWidget(
            label: "词性",
            hide: store.onOffWidget[2],
            click: (bool status){ store.onOffWidget[2]=!status; store.updateUI();},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          );
  }


  _buildRow4(BuildContext context, WordState word, Store store) =>
    OnOffWidget(
      label: "相关",
      hide: store.onOffWidget[1],
      click: (bool status){ store.onOffWidget[1]=!status; store.updateUI();},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _padding(
            ItemsEdit(
              label: "常用句型",
              data: word.word.w_sentence_pattern,
            ),
          ),
          _padding(
            ItemsEdit(
              label: "词汇搭配",
              data: word.word.w_word_collocation,
              options: store.partOfSpeechOptions,
            )
          ),
          _padding(
            InputTag(
              data: Provider.of<Store>(context, listen:true).synonym,
              tooltip: "输入近义词",
              lable: "近义词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { if(value.length == 0) return; Provider.of<Store>(context, listen:false).synonym.add(value); Provider.of<Store>(context, listen:false).updateUI();},
              delete: (String value) { Provider.of<Store>(context, listen:false).synonym.remove(value); Provider.of<Store>(context, listen:false).updateUI();},
            )
          ),
          _padding(
            InputTag(
              data: Provider.of<Store>(context, listen:true).antonym,
              tooltip: "输入反义词",
              lable: "反义词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { if(value.length == 0) return; Provider.of<Store>(context, listen:false).antonym.add(value); Provider.of<Store>(context, listen:false).updateUI();},
              delete: (String value) { Provider.of<Store>(context, listen:false).antonym.remove(value); Provider.of<Store>(context, listen:false).updateUI();},
            )
          ),
        ],  
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Consumer2<WordState, Store>(
      builder: (BuildContext context, WordState word, Store store, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("添加或编辑单词"),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow1(context, word),
                  SizedBox(height: 20,),
                  _buildRow2(context, word, store),
                  SizedBox(height: 20,),
                  _buildRow3(context, word, store),
                  SizedBox(height: 20,),
                  _buildRow4(context, word, store),
                ],
              ),
            ), 
          ),
        );
      }
    );
  }
}


class OnePartOfSpeech extends StatelessWidget {
  final Map _data;
  final int _index;
  final Function(Object) _delete;
  final List<String> _options;

  OnePartOfSpeech({Key key, Map data, int index, Function(Object) delete, List<String> options})
    : _data = data,
      _index = index,
      _delete = delete,
      _options = options,
     super(key:key);

  _head(BuildContext context) {
    return DeletableDropdownButton(
        options:_options,
        value: _data["type"],
        close: (value) {
          _data["type"] = value;
          Provider.of<Store>(context, listen:false).updateUI();
        },
        delete: (){if(_delete != null) _delete(_data);},
      );
  }

  _children(BuildContext context) {
    var delete = (Object obj) {
      _data["items"].remove(obj);
      Provider.of<Store>(context, listen:false).updateUI();
    };

    List<Widget> children = [_head(context)];

    _data["items"].forEach((val){
      children.add(
        Padding(
          padding: EdgeInsets.fromLTRB(20,0,0,0),
          child: ItemEdit(
              data: val,
              index: _data["items"].indexOf(val) + 1,
              indent: 3,
              delete: delete,
            ),
          )
      );
    });

    children.add(
      Padding(
        padding: EdgeInsets.fromLTRB(20,0,0,20),
        child: IconButton(
          icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
          padding: EdgeInsets.zero,
          tooltip: "添加同性释义",
          splashRadius:1,
          onPressed: () {
            _data["items"].add(
              {
                "type":"",
                "sentences":[blankSentence(),]
              }
            );
            Provider.of<Store>(context, listen:false).updateUI();
          },
        ),
      )
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _children(context),
            );
  }
}
