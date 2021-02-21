import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';


class InputTag extends StatelessWidget {
  final List<String> _data;
  final String _lable;
  final Widget _icon;
  final String _tooltip;
  final Function(String) _add;
  final Function(String) _delete;

  InputTag({Key key, List<String> data, String lable, Widget icon, String tooltip="", Function(String) add, Function(String) delete})
    : _data = data,
      _lable = lable,
      _icon = icon,
      _tooltip = tooltip,
      _add = add,
      _delete = delete,
      super(key: key);

  _chips(BuildContext context) {
    var chips = _data.map(
      (String val) => Chip(
                        label: Text(val),
                        deleteIcon: Icon(Icons.clear, size: 16,),
                        onDeleted: (){if(_delete != null) _delete(val);},
                      )
    );

    return chips.toList();
  }

  _chipTheme(BuildContext context) => ChipTheme(
              data: ChipThemeData( // 统一设置Chip组件样式
                backgroundColor: Colors.blueGrey,
                disabledColor: Colors.yellow,
                deleteIconColor: Colors.white,
                selectedColor: Colors.blue,
                secondarySelectedColor: Colors.black,
                labelPadding: EdgeInsets.all(0),
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: new BorderSide(style: BorderStyle.none,)),
                labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                secondaryLabelStyle: TextStyle(color: Colors.white),
                brightness: Brightness.dark,
                elevation: 20,
                shadowColor: Colors.lime,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0, 
                children: _chips(context),
              ), 
            );

  @override
  Widget build(BuildContext context) {
    return Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(_lable),
                  _chipTheme(context),
                  InputDialog(
                    icon: _icon,
                    tooltip: _tooltip,
                    close: (String value){if(_add != null) _add(value);},
                  ),
                ],
              );
  }
}
