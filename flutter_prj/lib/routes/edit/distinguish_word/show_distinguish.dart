import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import 'package:flutter_prj/widgets/edit_delete.dart';


class ShowDistinguish extends StatefulWidget {
  final DistinguishSerializer _distinguish;
  final Function _delete;

  ShowDistinguish({Key key, DistinguishSerializer distinguish, Function delete})
    : _distinguish = distinguish,
      _delete = delete,
      super(key:key);

  @override
  _ShowDistinguishState createState() => _ShowDistinguishState();
}

class _ShowDistinguishState extends State<ShowDistinguish> {

  @override
  Widget build(BuildContext context) =>
    ListTile(
      leading: Text('id[${widget._distinguish.id}]', style: TextStyle(fontSize: 12, color: Colors.deepOrange),),
      title: Text(widget._distinguish.wordsForeign.join(', ')),
      trailing: EditDelete(
        edit: () async {
          var distinguish = (await Navigator.pushNamed(context, '/edit_distinguish', arguments:{'title':'编辑词义辨析','distinguish': DistinguishSerializer().from(widget._distinguish)})) as DistinguishSerializer;
            if(distinguish != null) await widget._distinguish.from(distinguish).save();
            setState(() {});
        },
        delete: widget._delete,
      ),
    );
}
