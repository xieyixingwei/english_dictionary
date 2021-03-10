import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/etyma.dart';


class EditEtyma extends StatefulWidget {
  final String _title;
  final EtymaSerializer _etyma;

  EditEtyma({Key key, String title, EtymaSerializer etyma})
    : _title = title,
      _etyma = etyma ?? EtymaSerializer(),
      super(key: key);

  @override
  _EditEtymaState createState() => _EditEtymaState();
}

class _EditEtymaState extends State<EditEtyma> {
  static const List<String> _options = ['选择', '前缀', '后缀', '词根'];
  String _select = _options.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(widget._title),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton(
                      value: _select,
                      items: _options.map((e)=>DropdownMenuItem(child: Text(e), value: e,)).toList(),
                      onChanged: (v) {
                        if(v != _options.first) {
                          widget._etyma.e_type = _options.indexOf(v) - 1;
                        }
                        setState(() => _select = v);
                      },
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 100.0,
                      child: TextField(
                        controller: TextEditingController(text:widget._etyma.e_name ?? ''),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          labelText: "词根词缀",
                        ),
                        onChanged: (value) => widget._etyma.e_name = value.trim(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: TextEditingController(text:widget._etyma.e_meaning),
                  minLines: 2,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    labelText: "含义",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => widget._etyma.e_meaning = value.trim(),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      splashRadius: 1.0,
                      icon: Icon(Icons.done, color: Colors.green,),
                      tooltip: '确定',
                      onPressed: () => Navigator.pop(context, widget._etyma),
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
              ]
            ),
          ),
    );
  }
}
