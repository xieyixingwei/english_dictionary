import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/store.dart';
import 'ItemEdit.dart';


class ItemsEdit extends StatelessWidget {
  final List<Map> _data;
  final String _label;
  final List<String> _options;

  ItemsEdit({Key key, List<Map> data, String label, List<String> options})
    : _data = data,
      _label = label,
      _options = options,
     super(key:key);

  _children(BuildContext context) {
    List<Widget> children = [];

    var delete = (Object that) {
      _data.remove(that);
      Provider.of<Store>(context, listen:false).updateUI();
    };

    _data.forEach((Map val){
      children.add(ItemEdit(data:val, label:_label, index: _data.indexOf(val) + 1, indent: 2, delete:delete, options:_options,));
    });

    children.add(
      IconButton(
        icon: Icon(Icons.add, color: Color.fromRGBO(158,158,158,1),),
        padding: EdgeInsets.zero,
        splashRadius:1,
        tooltip: "添加" + _label,
        onPressed: () {
          _data.add(
            {
              "type":"",
              "sentences":[]
            }
          );
          Provider.of<Store>(context, listen:false).updateUI();
        },
      ),
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    //print("----- InputAdder build");
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _children(context),
          );
  }
}
