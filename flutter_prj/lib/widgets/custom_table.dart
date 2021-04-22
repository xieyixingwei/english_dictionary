import 'package:flutter/material.dart';


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
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20,),
              onPressed: () => goto != null && (index > 1) ? goto(index - 1) : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _indexs(),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 20,),
              onPressed: () => goto != null && (index < count) ? goto(index + 1) : null,
            ),
            DropdownButton(
              elevation: 10,
              value: perPage,
              items: perPages.map((e)=>DropdownMenuItem(child: Text('$e'), value: e,)).toList(),
              onChanged: (v) => perPageChange != null ? perPageChange(v) : null,
              underline: Divider(height:1, thickness: 1),
            ),
          ].where((e) => e != null).toList(),
        )
      ].where((e) => e != null).toList(),
    );

  List<Widget> _indexs() {
    var indexs = List<Widget>.generate(count, (i) =>
                TextButton(
                  child: Text('${i+1}'),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(index==(i+1) ? Colors.blue[100] : Colors.transparent)),
                  onPressed: () => goto != null ? goto(i+1) : null,
                )
              );
    return indexs;
  }

}
