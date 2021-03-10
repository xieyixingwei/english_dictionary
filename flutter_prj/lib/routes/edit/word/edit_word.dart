import 'package:flutter/material.dart';
import 'package:flutter_prj/common/global.dart';
import 'package:flutter_prj/routes/edit/word/word_details.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/SelectDialog.dart';
import 'package:flutter_prj/widgets/Tag.dart';
import 'package:flutter_prj/widgets/popup_memu_button.dart';


class EditWord extends StatefulWidget {
  final String _title;
  final WordSerializer _word;

  EditWord({Key key, String title, WordSerializer word})
    : _title = title,
      _word = word != null ? word : WordSerializer(),
      super(key:key);

  @override
  _EditWordState createState() => _EditWordState();
}

class _EditWordState extends State<EditWord> {
  final _textStyle = const TextStyle(fontSize: 14,);
  static const List<String> _options = ['添加Tag', '添加词根词缀', '添加变形单词', '设置同义词', '设置反义词', '编辑Tags', '编辑词根词缀'];
  static const List<String> _morphOptions = ['选择', '过去分词', '现在分词', '形容词', '动词', '副词'];
  String _morphSelect = _morphOptions.first;
  String _morphInput = '';

  _editMorph(BuildContext context) async {
    _morphInput = '';
    await showDialog(
      context: context,
      builder: (context) =>
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
            SimpleDialog(
              title: Text('编辑变形单词'),
              contentPadding: EdgeInsets.fromLTRB(10,10,10,10),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(
                      value: _morphSelect,
                      items: _morphOptions.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      onChanged: (v) {setState(() => _morphSelect = v);},
                    ),
                    SizedBox(width: 8.0,),
                    Container(
                      width: 100,
                      child: TextField(
                        maxLines: null,
                        onChanged: (val) {
                          if(_morphSelect != _morphOptions.first && val.trim().isNotEmpty)
                            _morphInput = '$_morphSelect: ${val.trim()}';
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
    );

  if(_morphInput.isNotEmpty)
    setState(() => widget._word.w_morph.add(_morphInput));
}
  _onSelected(String value) async {
    if(value == '添加Tag') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.wordTagOptions,
        close: (String val) => setState(() => widget._word.w_tags.add(val)),
      );
    } else if(value == '添加词根词缀') {
      popSelectDialog(
        context: context,
        title: value,
        options: Global.etymaOptions,
        close: (String val) => setState(() => widget._word.w_etyma.add(val)),
      );
    } else if(value == '添加变形单词') {
      _editMorph(context);
    } else if(value == '设置同义词') {
      var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'设置同义句'})) as WordSerializer;
      if(word != null) {
        await word.create(update: true);
        widget._word.w_synonym.add(word.w_name);
        setState((){});
      }
    } else if(value == '设置反义词') {
      var word = (await Navigator.pushNamed(context, '/edit_word', arguments: {'title':'设置反义句'})) as WordSerializer;
      if(word != null) {
        await word.create(update: true);
        widget._word.w_antonym.add(word.w_name);
        setState((){});
      }
    } else if(value == '编辑Tags') {
      Navigator.pushNamed(context, '/edit_word_tags');
    } else if(value == '编辑词根词缀') {
      Navigator.pushNamed(context, '/edit_etyma');
    }
  }

  _buildRow1(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 100,
          child: TextField(
            controller: TextEditingController(text:widget._word.w_name),
            style: _textStyle,
            decoration: InputDecoration(
              labelText: "单词",
              suffixIcon: InkWell(
                child: Icon(Icons.search,),
                onTap: () async { if(widget._word.w_name.isEmpty) return; await widget._word.retrieve(update:true); setState((){});},
              ),
            ),
            onChanged: (String value) => widget._word.w_name = value.trim().isEmpty ? null : value.trim(),
          ),
        ),
        Container(
          width: 100,
          child: TextField(
            controller: TextEditingController(text:widget._word.w_voice_us),
            style: _textStyle,
            decoration: InputDecoration(
              labelText: "音标(美)",
            ),
            onChanged: (String value) => widget._word.w_voice_us = value,
          ),
        ),
        Container(
          width: 100,
          child:TextField(
            controller: TextEditingController(text:widget._word.w_voice_uk),
            style: _textStyle,
            decoration: InputDecoration(
              labelText: "音标(英)",
            ),
            onChanged: (String value) => widget._word.w_voice_uk = value,
          ),
        ),
        popupMenuButton(context:context, options:_options, onSelected:_onSelected),
      ],
    );
  }

  _buildMorph(BuildContext context) =>
    Wrap(
      spacing: 8.0,
      runSpacing: 8.0, 
      children: widget._word.w_morph.map<Widget>((e) =>
        Tag(
          label: Text(e, style: TextStyle(color: Colors.indigo),),
          onDeleted: () => setState(() => widget._word.w_morph.remove(e)),
        )
      ).toList(),
    );

  _buildOrigin(BuildContext context) =>
    TextField(
      controller: TextEditingController(text:widget._word.w_origin),
      minLines: 2,
      maxLines: null,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: "词源",
        hintText: "输入词源(markdown)",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => widget._word.w_origin = value.trim(),
    );
  
  _buildShorthand(BuildContext context) =>
    TextField(
      controller: TextEditingController(text:widget._word.w_shorthand),
      minLines: 2,
      maxLines: null,
      style: TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: "速记",
        hintText: "输入速记(markdown)",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => widget._word.w_shorthand = value.trim(),
    );
/*
  _buildRow2(BuildContext context) {
    wOrigin.text = widget._word.w_origin;
    wShorthand.text = widget._word.w_shorthand;
    return OnOffWidget(
      label: "详情",
      hide: misc.onOffWidget[0],
      click: (bool status) {misc.onOffWidget[0] = !status; misc.updateUI();},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _padding(
            SelectTag(
              data: widget._word.w_tags,
              options: misc.wordTagOptions,
              tooltip: "添加Tag",
              lable: "Tag:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { widget._word.w_tags.add(value); word.notifyListeners();},
              delete: (String value) { widget._word.w_tags.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            InputTag(
              data: widget._word.w_etyma,
              tooltip: "输入词根词缀",
              lable: "词根词缀:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { widget._word.w_etyma.add(value); word.notifyListeners();},
              delete: (String value) { widget._word.w_etyma.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            InputTag(
              data: widget._word.w_morph,
              tooltip: "输入变型单词",
              lable: "变型单词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { widget._word.w_morph.add(value); word.notifyListeners();},
              delete: (String value) { widget._word.w_morph.remove(value); word.notifyListeners();},
            )
          ),
        ],
      ),
    );
  }

  _buildRow3(BuildContext context, WordModel word, MiscModel misc) {
    List<Widget> children = [];

    var delete = (Object that) {
      widget._word.w_partofspeech.remove(that);
      Provider.of<MiscModel>(context, listen:false).updateUI();
    };

    widget._word.w_partofspeech.forEach((val){
      var index = widget._word.w_partofspeech.indexOf(val) + 1;
      children.add(OnePartOfSpeech(data:val, index:index, delete:delete, options:misc.partOfSpeechOptions));
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
            widget._word.w_partofspeech.add(
              {
                "type":"",
                "items":[]
              }
            );
            Provider.of<MiscModel>(context, listen:false).updateUI();
          },
        ),
      )
    );
    return OnOffWidget(
            label: "词性",
            hide: misc.onOffWidget[2],
            click: (bool status){ misc.onOffWidget[2]=!status; misc.updateUI();},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          );
  }


  _buildRow4(BuildContext context, WordModel word, MiscModel store) =>
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
              data: widget._word.w_word_pattern,
            ),
          ),
          _padding(
            ItemsEdit(
              label: "词汇搭配",
              data: widget._word.w_word_collocation,
              options: store.partOfSpeechOptions,
            )
          ),
          _padding(
            InputTag(
              data: widget._word.w_synonym,
              tooltip: "输入近义词",
              lable: "近义词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { if(value.length == 0) return; widget._word.w_synonym.add(value); word.notifyListeners();},
              delete: (String value) { widget._word.w_synonym.remove(value); word.notifyListeners();},
            )
          ),
          _padding(
            InputTag(
              data: widget._word.w_antonym,
              tooltip: "输入反义词",
              lable: "反义词:",
              icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
              add: (String value) { if(value.length == 0) return; widget._word.w_antonym.add(value); word.notifyListeners();},
              delete: (String value) { widget._word.w_antonym.remove(value); word.notifyListeners();},
            )
          ),
        ],  
      ),
    );
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow1(context),
                  SizedBox(height: 20,),
                  WordDetails(word: widget._word, editable:true),
                  SizedBox(height: 20,),
                  _buildMorph(context),
                  SizedBox(height: 20,),
                  _buildOrigin(context),
                  SizedBox(height: 20,),
                  _buildShorthand(context),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.done, color: Colors.green,),
                        tooltip: '确定',
                        onPressed: () => Navigator.pop(context, widget._word),
                      ),
                      SizedBox(width: 10,),
                      IconButton(
                        splashRadius: 1.0,
                        icon: Icon(Icons.clear, color: Colors.grey,),
                        tooltip: '取消',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]
                  ),
                ],
              ),
            ), 
          ),
        );
  }
}

/*
class OnePartOfSpeech extends StatelessWidget {
  final PartOfSpeechSerializer _data;
  final int _index;
  final Function(Object) _delete;
  final List<String> _options;

  OnePartOfSpeech({Key key, PartOfSpeechSerializer data, int index, Function(Object) delete, List<String> options})
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
*/
