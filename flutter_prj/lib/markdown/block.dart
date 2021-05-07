import 'package:flutter/material.dart';
import 'package:flutter_prj/markdown/markdown.dart';
import 'package:flutter_prj/markdown/style.dart' as style;
import 'package:flutter_prj/widgets/column_space.dart';


abstract class MarkBlockItem {
  RegExp get regExp;
  Widget render(RegExpMatch match);
}


class MarkTitle extends MarkBlockItem {
  @override
  RegExp get regExp => RegExp(r'^ *#+ *([^\n]+?)(?:\n+|$)');

  @override
  Widget render(RegExpMatch match) =>
    Container(
      margin: EdgeInsets.only(bottom: 14, top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            match[1],
            style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none
            ),
          ),
          SizedBox(height: 8,),
          Divider(height: 1, color: Colors.black12, indent: 17, endIndent: 34,),
        ],
      ),
    );
}


class MarkList extends MarkBlockItem {
  @override
  RegExp get regExp => RegExp(r'^(?: *(?:\d+\.|[-+*]) +[^\n]+(?:\n[^\n]+)*?\n)+(?:\n+|$)');

  @override
  Widget render(RegExpMatch match) {
    var treeItems = _pickupItems(match[0]);
    return Container(
            margin: EdgeInsets.only(bottom: 8),
            child: _list(treeItems['children'], 0)
          );
  }

  Map _pickupItems(String text) {
    var re = RegExp(r'^( *)(\d+\.|[-+*]) +([\s\S]*?)\n(?= *(\d+\.|[-+*]) +|$)');
    List<Map> items = [];

    while(text.isNotEmpty) {
      var cap = re.firstMatch(text);
      if(cap != null) {
        items.add({ 'indent': cap[1].length,
                    'prefix': cap[2].trim(),
                    'text': cap[3].trim(),
                    'parent': null,
                    'children': <Map>[]});
        text = text.substring(cap[0].length);
      }
    }

    items = items.reversed.toList();
    Map rootItem = {'indent': 0,
                    'parent': null,
                    'children': <Map>[]};

    var cur = items.removeLast();
    cur['parent'] = rootItem;
    rootItem['children'].add(cur);

    while(items.isNotEmpty) {
      var i = items.removeLast();
      cur = _treeItem(cur, i);
    }

    return rootItem;
  }

  Map _treeItem(Map cur, Map item) {
    if(item['indent'] == cur['indent']) {
        item['parent'] = cur['parent'];
        cur['parent']['children'].add(item);
        return item;
    }
    else if(item['indent'] > cur['indent']) {
        item['parent'] = cur;
        cur['children'].add(item);
        return item;
    }
    else
      return _treeItem(cur['parent'], item);
  }

  Widget _list(List<Map> items, num ulicon) {
    if(items.isEmpty) return null;
    Widget prefix;
    var olRegExp = RegExp(r'^\d+\.');
    bool ul = false;

    if(olRegExp.hasMatch(items[0]['prefix'])) {
      ul = false;
    } else if (RegExp(r'^[-+*]').hasMatch(items[0]['prefix'])) {
      prefix = Icon((ulicon == 0) ? Icons.lens : Icons.radio_button_checked, size: 10, color: Colors.black54,);
      ul = true;
    }

    return ColumnSpace(
        crossAxisAlignment: CrossAxisAlignment.start,
        divider: SizedBox(height: 2,),
        children: items.map((e) =>
          ColumnSpace(
            crossAxisAlignment: CrossAxisAlignment.start,
            divider: SizedBox(height: 2,),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: e['indent']*14,),
                  Padding(
                    padding: EdgeInsets.only(top: ul ? 5 : 3),
                    child:  ul ? prefix : SelectableText(olRegExp.firstMatch(e['prefix'])[0], style: style.textStyle),
                  ),
                  SizedBox(width: 4,),
                  Flexible(
                    child: MarkDown.inlineRender(
                      e['text'],
                    )
                  ),
                ],
              ),
              _list(e['children'], ul == false ? 0 : 1),
            ].where((e) => e != null).toList(),
          ),
        ).toList(),
      );
  }
}


class MarkParagraph extends MarkBlockItem {
  @override
  RegExp get regExp => RegExp(r'^(.*?)(?:\n+|$)');

  @override
  Widget render(RegExpMatch match) {
    return Container(
            margin: EdgeInsets.only(bottom: 8),
            child: MarkDown.inlineRender(match[1])
          );
  }
}
