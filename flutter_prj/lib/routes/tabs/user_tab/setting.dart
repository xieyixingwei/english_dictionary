import 'package:flutter/material.dart';
import 'package:flutter_prj/serializers/index.dart';
import '../../../common/global.dart';


class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('账号管理'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('学习设置'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await Global.localStore.user.retrieve();
              var plan = await Navigator.pushNamed(
                                            context, "/study_settings",
                                            arguments: {'plan': StudyPlanSerializer().from(Global.localStore.user.studyPlan)}
                                            ) as StudyPlanSerializer;
              if(plan != null) {
                plan.foreignUser = Global.localStore.user.id;
                if(Global.localStore.user.studyPlan == null)
                  Global.localStore.user.studyPlan = plan;
                else
                  Global.localStore.user.studyPlan.from(plan);
                await Global.localStore.user.studyPlan.save();
              }
            }
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
            child: ElevatedButton(
              child: Text('退出登录'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () {
                Global.clear();
                Navigator.pushNamed(context, "/login");
              } 
            ),
          ),
        ],
      ),
    );
  }
}
