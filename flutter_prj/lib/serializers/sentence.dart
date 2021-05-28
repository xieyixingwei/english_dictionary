// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'grammar.dart';
import 'package:flutter_prj/common/http.dart';


class SentenceSerializer {
  SentenceSerializer();

  num _id;
  num id;
  String en = '';
  String enVoice = '';
  String cn = '';
  String cnVoice = '';
  num type = 0;
  List<String> tag = [];
  String tense = '';
  List<String> pattern = [];
  List<num> synonym = [];
  List<num> antonym = [];
  num paraphraseForeign;
  List<GrammarSerializer> grammarSet = [];
  bool offstage = true;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/sentence/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'id': res.data['id'] ?? id};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/sentence/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence/$id/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/sentence/$id/');
    /*
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(grammarSet, (e) async {e.sentenceForeign = id; await e.save();});
    }
    
    return res;
  }

  SentenceSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? id : json['id'] as num;
    en = json['en'] == null ? en : json['en'] as String;
    cn = json['cn'] == null ? cn : json['cn'] as String;
    type = json['type'] == null ? type : json['type'] as num;
    tag = json['tag'] == null
                ? tag
                : json['tag'].map<String>((e) => e as String).toList();
    tense = json['tense'] == null ? tense : json['tense'] as String;
    pattern = json['pattern'] == null
                ? pattern
                : json['pattern'].map<String>((e) => e as String).toList();
    synonym = json['synonym'] == null
                ? synonym
                : json['synonym'].map<num>((e) => e as num).toList();
    antonym = json['antonym'] == null
                ? antonym
                : json['antonym'].map<num>((e) => e as num).toList();
    paraphraseForeign = json['paraphraseForeign'] == null ? paraphraseForeign : json['paraphraseForeign'] as num;
    grammarSet = json['grammarSet'] == null
                ? grammarSet
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'en': en,
    'cn': cn,
    'type': type,
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'tense': tense,
    'pattern': pattern == null ? null : pattern.map((e) => e).toList(),
    'synonym': synonym == null ? null : synonym.map((e) => e).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e).toList(),
    'paraphraseForeign': paraphraseForeign,
  }..removeWhere((k, v) => v==null);


  SentenceSerializer from(SentenceSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    en = instance.en;
    enVoice = instance.enVoice;
    cn = instance.cn;
    cnVoice = instance.cnVoice;
    type = instance.type;
    tag = List.from(instance.tag);
    tense = instance.tense;
    pattern = List.from(instance.pattern);
    synonym = List.from(instance.synonym);
    antonym = List.from(instance.antonym);
    paraphraseForeign = instance.paraphraseForeign;
    grammarSet = List.from(instance.grammarSet.map((e) => GrammarSerializer().from(e)).toList());
    offstage = instance.offstage;
    _id = instance._id;
    return this;
  }
}


