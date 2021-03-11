import 'package:flutter/material.dart';
import 'package:flutter_prj/models/word_model.dart';
import 'package:flutter_prj/widgets/RatingStar.dart';
import 'package:provider/provider.dart';


class SearchInput extends StatelessWidget {
  final TextEditingController _inputText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
          ),
          controller: _inputText,
          decoration: InputDecoration(
            hintText: "输入单词或句子",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              iconSize: 38,
              icon: Icon(Icons.search),
              onPressed: () {
                //print("search ........");
                print(_inputText.text);
              },
            ),
          ),
        );
  }
}


class HomeBody extends StatelessWidget {

  _padding(Widget child) =>
    Padding(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
      child: child,
    );

  _wordName(BuildContext context) =>
    Row(
      children: [
        Text(
          Provider.of<WordModel>(context, listen:false).word.name,
          style: TextStyle(
            color: Color.fromRGBO(0,153,68,1),
            fontWeight: FontWeight.w700,
            fontSize: 30
          ),
        ),
        IconButton(
          icon: Icon(Icons.assignment, color: Color.fromRGBO(42,165,183,1),),
          splashRadius: 1,
          onPressed: () => print("添加到单词本"),
        ),
        ratingStar(3.3,5),
      ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: EdgeInsets.all(5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _padding(SearchInput()),
        _padding(_wordName(context)),
      ],
    );
  }
}
