import 'package:flutter/material.dart';


Widget ratingStar(double score, int total) {
    List<Widget> _list = [];
    for (var i = 0; i < total; i++) {
      double factor = (score - i);
      if (factor >= 1) {
        factor = 1.0;
      }else if (factor < 0){
        factor = 0;
      }
      Stack _st = Stack(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          ClipRect(
            child: 
            Align(
              alignment: Alignment.topLeft,
              widthFactor: factor,
              child: Icon(
                Icons.star,
                color: Colors.redAccent,
              ),
            )
          )
        ],
      );
      _list.add(_st);
    }
    return Row(
      children:_list
    );
}
