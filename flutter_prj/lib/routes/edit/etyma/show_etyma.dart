import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/edit/etyma/edit_etyma.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/column_space.dart';


class ShowEtymaPage extends StatefulWidget {

  ShowEtymaPage({Key key, this.title, this.etyma}) : super(key: key);

  final String title;
  final String etyma;

  @override
  _ShowEtymaPageState createState() => _ShowEtymaPageState();
}

class _ShowEtymaPageState extends State<ShowEtymaPage> {

  EtymaSerializer _etyma = EtymaSerializer();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _etyma.name = widget.etyma;
    await _etyma.retrieve();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: ColumnSpace(
          crossAxisAlignment: CrossAxisAlignment.start,
          divider: SizedBox(height: 16,),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_etyma.name, style: TextStyle(fontSize: 28, color: Colors.black87, fontWeight: FontWeight.bold)),
                SizedBox(width: 10,),
                Text(EditEtyma.options[_etyma.type], style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
            Text(_etyma.interpretation, style: TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        ),
      ),
    );
}


Widget etymaItem({BuildContext context, EtymaSerializer etyma, Widget trailing}) {
  Widget title = Text.rich(
    TextSpan(
        children: [
          TextSpan(text: '${etyma.name}', style: TextStyle(fontSize: 14, color: Colors.black87)),
          TextSpan(text: '    ${EditEtyma.options[etyma.type]}', style: TextStyle(fontSize: 10, color: Colors.black45)),
        ]
      )
  );
  return ListTile(
    dense: true,
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    minLeadingWidth: 30,
    contentPadding: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
    title: title,
    trailing: trailing,
  );
}
