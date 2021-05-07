import 'package:flutter/material.dart';
import 'package:flutter_prj/markdown/block.dart';
import 'package:flutter_prj/markdown/inline.dart';
import 'package:flutter_prj/markdown/style.dart' as style;


class MarkDown {
  static List<MarkBlockItem> blockItems = [
    MarkTitle(),
    MarkList(),

    MarkParagraph(),
  ];

  static List<MarkInlineItem> inlineItems = [
    MarkStrong(),
    MarkText(),
  ];

  List<Widget> widgets = [];

  MarkDown({this.text});

  String text;

  Widget render() {
    num count = 0;
    text += '\n';
    while(text != null && text.isNotEmpty) {
      for(var i in blockItems) {
        var match = i.regExp.firstMatch(text);
        if(match != null) {
          widgets.add(i.render(match));
          text = text.substring(match[0].length);
          break;
        }
      }
      count++;
      if(count > 10) break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  static Widget inlineRender(String text) {
    List<InlineSpan> children = [];
    while(text.isNotEmpty) {
      for(var i in inlineItems) {
        var match = i.regExp.firstMatch(text);
        if(match != null) {
          children.add(i.render(match));
          text = text.substring(match[0].length);
          break;
        }
      }
    }

    return SelectableText.rich(
      TextSpan(
        style: style.textStyle,
        children: children
      ),
    );
  }
}
