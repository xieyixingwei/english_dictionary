import 'package:flutter/material.dart';
import 'package:flutter_prj/widgets/InputDialog.dart';
import 'package:provider/provider.dart';
import '../../common/http.dart';
import '../../states/store.dart';


class EditWordTags extends StatelessWidget {

  _children(Store store) {
  var children = store.wordTagOptions.map((e) =>
      ListTile(
        title: Text(e),
        trailing: IconButton(
          splashRadius: 1.0,
          icon: Icon(Icons.clear),
          onPressed: () {
            store.wordTagOptions.remove(e);
            Http().deleteWordTagOption(e);
            store.updateUI();
          },
        ),
      )
    ).toList();
  children.add(
     ListTile(
      title: Text("添加 Tag"),
      leading: InputDialog(
        title: "添加 Tag",
        icon: Icon(Icons.add),
        close: (String value) {
          store.wordTagOptions.add(value);
          Http().createWordTagOption(value);
          store.updateUI();
        },
      ),
    ),
  );
  return children;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Store>(
      builder: (BuildContext context, Store store, Widget child) =>
        Scaffold(
          appBar: AppBar(
            title: Text("编辑单词Tags"),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: _children(store),
            ),
          ), 
    );
  }
}
