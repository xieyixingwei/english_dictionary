
import 'package:flutter/material.dart';


abstract class MarkInlineItem{
  RegExp get regExp;
  InlineSpan render(RegExpMatch match);
}


class MarkText extends MarkInlineItem {
  @override
  RegExp get regExp => RegExp(r'^[\s\S]+?(?=([<!\[_*`]| {2,}\n|~~|$))');

  @override
  InlineSpan render(RegExpMatch match) {
    return TextSpan(
        text: match[0],
    );
  }
}


class MarkStrong extends MarkInlineItem {
  @override
  RegExp get regExp => RegExp(r'^\*\*([\s\S]*?)\*\*');

  @override
  InlineSpan render(RegExpMatch match) {
    return TextSpan(
            text: match[1],
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          );
  }
}
