// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'study_plan.dart';
import 'study_grammar.dart';
import 'study_sentence.dart';
import 'package:flutter_prj/common/http.dart';


class UserSerializer {
  UserSerializer();

  num _id;
  num id;
  String uname = '';
  String passwd = '';
  bool isAdmin = false;
  String registerDate = '';
  String name = '';
  bool gender = true;
  String birthday = '';
  num education = 0;
  String wechart = '';
  String qq = '';
  String email = '';
  String telephone = '';
  String status = '';
  StudyPlanSerializer studyPlan = StudyPlanSerializer();
  List<StudyGrammarSerializer> studyGrammarSet = [];
  List<StudySentenceSerializer> studySentenceSet = [];

  Future<List<UserSerializer>> list({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/user/', queries:queries, cache:cache);
    return res != null ? res.data.map<UserSerializer>((e) => UserSerializer().fromJson(e)).toList() : [];
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/user/$uname/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/user/$uname/');
    /*
    if(studyPlan != null){studyPlan.delete();}
    if(studyGrammarSet != null){studyGrammarSet.forEach((e){e.delete();});}
    if(studySentenceSet != null){studySentenceSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/user/$uname/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> register({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/user/register/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'id': res.data['id'] ?? id};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  UserSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? id : json['id'] as num;
    uname = json['uname'] == null ? uname : json['uname'] as String;
    passwd = json['passwd'] == null ? passwd : json['passwd'] as String;
    isAdmin = json['isAdmin'] == null ? isAdmin : json['isAdmin'] as bool;
    registerDate = json['registerDate'] == null ? registerDate : json['registerDate'] as String;
    name = json['name'] == null ? name : json['name'] as String;
    gender = json['gender'] == null ? gender : json['gender'] as bool;
    birthday = json['birthday'] == null ? birthday : json['birthday'] as String;
    education = json['education'] == null ? education : json['education'] as num;
    wechart = json['wechart'] == null ? wechart : json['wechart'] as String;
    qq = json['qq'] == null ? qq : json['qq'] as String;
    email = json['email'] == null ? email : json['email'] as String;
    telephone = json['telephone'] == null ? telephone : json['telephone'] as String;
    status = json['status'] == null ? status : json['status'] as String;
    studyPlan = json['studyPlan'] == null
                ? studyPlan
                : StudyPlanSerializer().fromJson(json['studyPlan'] as Map<String, dynamic>);
    studyGrammarSet = json['studyGrammarSet'] == null
                ? studyGrammarSet
                : json['studyGrammarSet'].map<StudyGrammarSerializer>((e) => StudyGrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    studySentenceSet = json['studySentenceSet'] == null
                ? studySentenceSet
                : json['studySentenceSet'].map<StudySentenceSerializer>((e) => StudySentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'uname': uname,
    'passwd': passwd,
    'isAdmin': isAdmin,
    'registerDate': registerDate,
    'name': name,
    'gender': gender,
    'birthday': birthday,
    'education': education,
    'wechart': wechart,
    'qq': qq,
    'email': email,
    'telephone': telephone,
    'status': status,
    'studyPlan': studyPlan == null ? null : studyPlan.toJson(),
    'studyGrammarSet': studyGrammarSet == null ? null : studyGrammarSet.map((e) => e.toJson()).toList(),
    'studySentenceSet': studySentenceSet == null ? null : studySentenceSet.map((e) => e.toJson()).toList(),
  }..removeWhere((k, v) => v==null);


  UserSerializer from(UserSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    uname = instance.uname;
    passwd = instance.passwd;
    isAdmin = instance.isAdmin;
    registerDate = instance.registerDate;
    name = instance.name;
    gender = instance.gender;
    birthday = instance.birthday;
    education = instance.education;
    wechart = instance.wechart;
    qq = instance.qq;
    email = instance.email;
    telephone = instance.telephone;
    status = instance.status;
    studyPlan = StudyPlanSerializer().from(instance.studyPlan);
    studyGrammarSet = List.from(instance.studyGrammarSet.map((e) => StudyGrammarSerializer().from(e)).toList());
    studySentenceSet = List.from(instance.studySentenceSet.map((e) => StudySentenceSerializer().from(e)).toList());
    _id = instance._id;
    return this;
  }
}



