import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/row_space.dart';


class CustomTable extends StatelessWidget {

  CustomTable({
    Key key,
    this.title,
    this.header,
    this.rows,
    this.count,
    this.index,
    this.perPage,
    this.perPages,
    this.goto,
    this.perPageChange
  }) : super(key: key);

  final Widget title;
  final Widget header;
  final List<Widget> rows;
  final num count;
  final num index;
  final num perPage;
  final List<num> perPages;
  final void Function(num) goto;
  final void Function(num) perPageChange;
/*
  @override
  _CustomTableState createState() => _CustomTableState();
}


class _CustomTableState extends State<CustomTable> {
  num _perPage;

  @override
  void initState() {
    _perPage = perPage[0];
    super.initState();
  }
*/
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
              icon: Icon(Icons.arrow_back_ios, size: 20, color: (index > 1) ? Colors.blueAccent : Colors.black26,),
              splashRadius: 17,
              onPressed: () => goto != null && (index > 1) ? goto(index - 1) : null,
            )
          ] + _indexs() + <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 20, color: (index < count) ? Colors.blueAccent : Colors.black26),
              splashRadius: 17,
              onPressed: () => goto != null && (index < count) ? goto(index + 1) : null,
            ),
          ].where((e) => e != null).toList(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('总页数 $count', style: TextStyle(fontSize: 17, color: Colors.black38)),
            SizedBox(width: 17,),
            Text('每页', style: TextStyle(color: Colors.black38, fontSize: 17),),
            SizedBox(width: 8,),
            DropdownButton(
              value: perPage,
              isDense: true,
              items: perPages.map((e)=>DropdownMenuItem(child: Text('$e', style: TextStyle(fontSize: 17, color: Colors.black38),), value: e,)).toList(),
              onChanged: (v) => perPageChange != null ? perPageChange(v) : null,
              underline: Divider(height:1, thickness: 1),
            ),
          ]
        )
      ].where((e) => e != null).toList(),
    );

  List<Widget> _indexs() {
    final maxCount = 6;
    final maxCountHalf = maxCount / 2;
    final counts = count < maxCount ? count : maxCount;
    num start = 1;
    if(index - maxCountHalf > 0 && index + maxCountHalf <= count) {
      start = index - maxCountHalf;
    } else if(index - maxCountHalf <= 0) {
      start = 1;
    }else if(index + maxCountHalf > count) {
      start = count - maxCount + 1;
    }
    var indexs = List<Widget>.generate(counts, (i) =>
                TextButton(
                  child: Text('${i+start}', style: TextStyle(fontSize: 17, color: Colors.black38),),
                  style: TextButton.styleFrom(
                    backgroundColor: index==(i+start) ? Colors.blue[100] : Colors.transparent,
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
        if(index + maxCountHalf < count) {
          indexs.add(Text('......', style: TextStyle(fontSize: 17, color: Colors.black38),),);
          indexs.add(
                  TextButton(
                    child: Text('$count', style: TextStyle(fontSize: 17, color: Colors.black38),),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      minimumSize: Size(30, 30),
                    ),
                    onPressed: () => goto != null ? goto(count) : null,
                  ));
        }
    return indexs;
  }

}
