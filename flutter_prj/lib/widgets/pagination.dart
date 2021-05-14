import 'package:flutter/material.dart';


class Pagination extends StatelessWidget {

  Pagination({
    Key key,
    this.title,
    this.header,
    this.rows,
    this.pages,
    this.curPage,
    this.perPage,
    this.perPageSet,
    this.maxIndexs = 6,
    this.goto,
    this.perPageChange
  }) : super(key: key);

  final Widget title;
  final Widget header;
  final List<Widget> rows;
  final num pages;
  final num curPage;
  final num perPage;
  final num maxIndexs;
  final List<num> perPageSet;
  final void Function(num) goto;
  final void Function(num) perPageChange;

  @override
  Widget build(BuildContext context) =>
    Column(

      children: [
        title,
        header,
        Column(
          children: rows,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20, color: (curPage > 1) ? Colors.blueAccent : Colors.black26,),
              splashRadius: 17,
              onPressed: () => goto != null && (curPage > 1) ? goto(curPage - 1) : null,
            )
          ] + _indexs() + <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 20, color: (curPage < pages) ? Colors.blueAccent : Colors.black26),
              splashRadius: 17,
              onPressed: () => goto != null && (curPage < pages) ? goto(curPage + 1) : null,
            ),
          ].where((e) => e != null).toList(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('总页数 $pages', style: TextStyle(fontSize: 17, color: Colors.black38)),
            SizedBox(width: 17,),
            Text('每页', style: TextStyle(color: Colors.black38, fontSize: 17),),
            SizedBox(width: 8,),
            DropdownButton(
              value: perPage,
              isDense: true,
              items: perPageSet.map((e)=>DropdownMenuItem(child: Text('$e', style: TextStyle(fontSize: 17, color: Colors.black38),), value: e,)).toList(),
              onChanged: (v) => perPageChange != null ? perPageChange(v) : null,
              underline: Divider(height:1, thickness: 1),
            ),
          ]
        )
      ].where((e) => e != null).toList(),
    );

  List<Widget> _indexs() {
    final maxCountHalf = maxIndexs / 2;
    final count = pages < maxIndexs ? pages : maxIndexs;
    num start = 1;
    if(curPage - maxCountHalf > 0 && curPage + maxCountHalf <= pages) {
      start = curPage - maxCountHalf;
    } else if(curPage - maxCountHalf <= 0) {
      start = 1;
    }else if(curPage + maxCountHalf > pages) {
      start = pages - maxIndexs + 1;
    }
    var indexs = List<Widget>.generate(count, (i) =>
                TextButton(
                  child: Text('${i+start}', style: TextStyle(fontSize: 17, color: Colors.black38),),
                  style: TextButton.styleFrom(
                    backgroundColor: curPage==(i+start) ? Colors.blue[100] : Colors.transparent,
                    padding: EdgeInsets.only(left: 4, right: 4),
                    minimumSize: Size(30, 30),
                  ),
                  onPressed: () => goto != null ? goto(i+start) : null,
                )
              );
        if(start > 1) {
          indexs.insert(0,
                  TextButton(
                    child: Text('1', style: TextStyle(fontSize: 17, color: Colors.black38),),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      minimumSize: Size(30, 30),
                    ),
                    onPressed: () => goto != null ? goto(1) : null,
                  ));
          indexs.insert(1,Text('......', style: TextStyle(fontSize: 17, color: Colors.black38),),);
        }
        if(curPage + maxCountHalf < pages) {
          indexs.add(Text('......', style: TextStyle(fontSize: 17, color: Colors.black38),),);
          indexs.add(
                  TextButton(
                    child: Text('$pages', style: TextStyle(fontSize: 17, color: Colors.black38),),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      minimumSize: Size(30, 30),
                    ),
                    onPressed: () => goto != null ? goto(pages) : null,
                  ));
        }
    return indexs;
  }
}
