import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';


class EditTags extends StatefulWidget {
  final List<String> _tags;
  final Widget _title;
  final Function(String) _add;
  final Function(String) _remove;

  EditTags({Key key, Widget title, List<String> tags, Function(String) add, Function(String) remove})
    :
      _tags = tags,
      _title = title,
      _add = add,
      _remove = remove,
      super(key: key);

  @override
  _EditTagsState createState() => _EditTagsState();
}

class _EditTagsState extends State<EditTags> {

  _children(BuildContext context) {
    var children = widget._tags.map((e) =>
        ListTile(
          title: Text(e),
          trailing: IconButton(
            splashRadius: 1.0,
            icon: Icon(Icons.clear),
            onPressed: () => setState(() {
              widget._tags.remove(e);
              widget._remove(e);
              },
            ),
          ),
        )
      ).toList();
    children.add(
      ListTile(
        title: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text("添加"),
            onPressed: () => popInputDialog(
              context: context,
              title: Text("输入内容"),
              close: (String value) => setState(
                () {
                  widget._tags.add(value);
                  widget._add(value);
                }
              ),
            ),
          ),
      )
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: widget._title,
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: _children(context),
            ),
    );
  }
}
