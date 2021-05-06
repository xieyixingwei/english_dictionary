import 'package:flutter/material.dart';
import 'package:flutter_prj/markdown/block.dart';
import 'package:flutter_prj/markdown/inline.dart';


abstract class MarkItem {
  RegExp get regExp;
  Widget render(RegExpMatch match);
}


class MarkDown {
  static List<MarkItem> blockItems = [
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
    while(text != null && text.isNotEmpty) {
      for(var i in blockItems) {
        print('--- [$text]');
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

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0, //设置大小
          color: Colors.black87,//设置颜色
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8
        ),
        children: children
      ),
    );
  }
}
