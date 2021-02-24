import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';


class EditTags extends StatefulWidget {
  final List<String> _data;
  final Widget _title;
  final Function(String) _add;
  final Function(String) _remove;

  EditTags({Key key, Widget title, List<String> data, Function(String) add, Function(String) remove})
    :
      _data = data,
      _title = title,
      _add = add,
      _remove = remove,
      super(key: key);

  @override
  _EditTagsState createState() => _EditTagsState();
}

class _EditTagsState extends State<EditTags> {

  _children() {
  var children = widget._data.map((e) =>
      ListTile(
        title: Text(e),
        trailing: IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.clear),
          onPressed: () => setState(() {
            widget._data.remove(e);
            widget._remove(e);
            },
          ),
        ),
      )
    ).toList();
  children.add(
     ListTile(
      title: Text("添加 Tag"),
      leading: InputDialog(
        title: "添加 Tag",
        icon: Icon(Icons.add),
        close: (String value) => setState(() {
          widget._data.add(value);
          widget._add(value);
          },
        ),
      ),
    ),
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
              children: _children(),
            ),
    );
  }
}
