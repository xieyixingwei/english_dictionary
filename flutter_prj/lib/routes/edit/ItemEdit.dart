import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/DeletableDropdownButton.dart';
import 'package:provider/provider.dart';

import '../../states/store.dart';
import '../../widgets/SentencePatternEdit.dart';



class DeletebleEdit extends StatefulWidget {
  final String _data;
  final String _label;
  final int _index;
  final int _indent;
  final Function(Object) _delete;
  final Function(String) _onChanged;
  final TextEditingController _controller = new TextEditingController();

    DeletebleEdit({
      Key key,
      String data,
      String label,
      int index=0,
      int indent=1,
      Function(Object) delete,
      Function(String) onChanged})
    : _data = data,
      _label = label,
      _index = index,
      _indent = indent,
      _delete = delete,
      _onChanged = onChanged,
      super(key:key) {
        _controller.text = data;
      }

  @override
  _DeletebleEditState createState() => _DeletebleEditState();
}

class _DeletebleEditState extends State<DeletebleEdit> {
  bool status = true;

  _textField(BuildContext context) => MouseRegion(
      onEnter: (e) => setState((){ status = !status;}),
      onExit: (e)=> setState((){ status = !status;}),
      child: TextField(
        maxLines: 1,
        controller: widget._controller,
        style: TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: widget._label,
          suffixIcon: Offstage(
            offstage: status,
            child: InkWell(
              child: Icon(Icons.clear),
              onTap: (){if(widget._delete != null) widget._delete(widget._data);},
            ),
          ),
        ),
        onChanged: (String value){
          if(widget._onChanged != null) widget._onChanged(value);
        }
      ),
  );

  @override
  Widget build(BuildContext context) {
    //print("----- PatternLineEdit build ${_hintText[0]}");

    return _textField(context);
  }
}

class ItemEdit extends StatelessWidget {
  final Map _data;
  final String _label;
  final int _index;
  final int _indent;
  final Function(Object that) _delete;
  final List<String> _options;


  ItemEdit({Key key, Map data, String label, int index, int indent=1, Function(Object that) delete, List<String> options})
    : _data = data,
      _label = label,
      _index = index,
      _delete = delete,
      _options = options,
      _indent = indent,
     super(key:key);

  _header(BuildContext context) {
    if(_options != null) {
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
    else {
      return DeletebleEdit(
                data: _data["type"],
                label: _label,
                delete: (obj){if(_delete != null) _delete(_data); },
                onChanged: (String value) => _data["type"] = value,
              );
    }
  }

  _body(BuildContext context) {
    var delete = (Object that) {
      _data["sentences"].remove(that);
      Provider.of<Store>(context, listen:false).updateUI();
    };

    List<Widget> children = [_header(context)];

    _data["sentences"].forEach((val){
      children.add(
        Padding(
          padding: EdgeInsets.fromLTRB(20,0,0,20),
          child: SentencePatternEdit(
              data: val,
              delete: delete,
              onChanged: [(String value) => val["pattern"][0]=value, (String value) => val["pattern"][1]=value],
            ),
          ),
      );
    });

    children.add(
      Padding(
        padding: EdgeInsets.fromLTRB(20,0,0,20),
        child: IconButton(
          padding: EdgeInsets.zero,
          tooltip: "添加例句",
          splashRadius:1,
          icon: Icon(Icons.add, color:Color.fromRGBO(158,158,158,1)),
          onPressed: () {
            _data["sentences"].add(blankSentence());
            Provider.of<Store>(context, listen:false).updateUI();
          },
        )
      )
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    //print("----- LineEditAdder build ${_data["type"]}");

    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _body(context),
          );
  }
}
