// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'sentence.dart';
import 'grammar.dart';
import 'study_sentence.dart';
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
  List<SentenceSerializer> synonym = [];
  List<SentenceSerializer> antonym = [];
  num paraphraseForeign;
  num dialogForeign;
  List<GrammarSerializer> grammarSet = [];
  List<StudySentenceSerializer> studySentenceSet = [];
  bool offstage = true;
  bool updateSynonum = false;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/sentence/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in create to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/sentence/$id/', data:data ?? toJson(), queries:queries, cache:cache);
    fromJson(res?.data, slave:false); // Don't update slave forign members in update to avoid erasing newly added associated data
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/sentence/$id/', queries:queries, cache:cache);
    fromJson(res?.data);
    return res != null;
  }

  Future<bool> delete({num pk}) async {
    if(_id == null && pk == null) return true;
    if(pk != null) id = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/sentence/$id/');
    /*
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    if(studySentenceSet != null){studySentenceSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _id == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(grammarSet, (e) async {e.sentenceForeign = id; await e.save();});
      await Future.forEach(studySentenceSet, (e) async { await e.save();});
    }
    
    return res;
  }

  SentenceSerializer fromJson(Map<String, dynamic> json, {bool slave = true}) {
    if(json == null) return this;
    id = json['id'] == null ? id : json['id'] as num;
    en = json['en'] == null ? en : json['en'] as String;
    enVoice = json['enVoice'] == null ? enVoice : json['enVoice'] as String;
    cn = json['cn'] == null ? cn : json['cn'] as String;
    cnVoice = json['cnVoice'] == null ? cnVoice : json['cnVoice'] as String;
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
                : json['synonym'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    antonym = json['antonym'] == null
                ? antonym
                : json['antonym'].map<SentenceSerializer>((e) => SentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
    paraphraseForeign = json['paraphraseForeign'] == null ? paraphraseForeign : json['paraphraseForeign'] as num;
    dialogForeign = json['dialogForeign'] == null ? dialogForeign : json['dialogForeign'] as num;
    _id = id;
    if(!slave) return this;
    grammarSet = json['grammarSet'] == null
                ? grammarSet
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    studySentenceSet = json['studySentenceSet'] == null
                ? studySentenceSet
                : json['studySentenceSet'].map<StudySentenceSerializer>((e) => StudySentenceSerializer().fromJson(e as Map<String, dynamic>)).toList();
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
    'synonym': synonym == null ? null : synonym.map((e) => e.id).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e.id).toList(),
    'paraphraseForeign': paraphraseForeign,
    'dialogForeign': dialogForeign,
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
    synonym = List.from(instance.synonym.map((e) => SentenceSerializer().from(e)).toList());
    antonym = List.from(instance.antonym.map((e) => SentenceSerializer().from(e)).toList());
    paraphraseForeign = instance.paraphraseForeign;
    dialogForeign = instance.dialogForeign;
    grammarSet = List.from(instance.grammarSet.map((e) => GrammarSerializer().from(e)).toList());
    studySentenceSet = List.from(instance.studySentenceSet.map((e) => StudySentenceSerializer().from(e)).toList());
    offstage = instance.offstage;
    updateSynonum = instance.updateSynonum;
    _id = instance._id;
    return this;
  }
}



