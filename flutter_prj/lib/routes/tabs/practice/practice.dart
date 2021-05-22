import 'package:flutter/material.dart';
import 'package:flutter_prj/routes/tabs/practice/word_practice.dart';


class TabPractice extends StatefulWidget {
  TabPractice({Key key}) : super(key: key);

  @override
  _TabPractice createState() => _TabPractice();
}


class _TabPractice extends State<TabPractice> {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('练习'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            _card(context, '单词', ()=>Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WordPracticePage(),
                  )
                )),
            _card(context, '句子', (){}),
            _card(context, '语法', (){}),
            _card(context, '词义辨析', (){}),
          ],
        ),
      ),
    );

  Widget _card(BuildContext context, String title, Function onPressed) =>
    Container(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      alignment: Alignment.center,
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        /*boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(5.0, 5.0), blurRadius: 5.0, spreadRadius: 1.0),
          BoxShadow(color: Colors.black26, offset: Offset(1.0, 1.0)), BoxShadow(color: Colors.black26)
        ],*/
      ),
      child: InkWell(
        child: Text(title, style: TextStyle(fontSize: 17),),
        onTap: onPressed,
      ),
    );
}
