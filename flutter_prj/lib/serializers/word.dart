// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'paraphrase.dart';
import 'sentence_pattern.dart';
import 'grammar.dart';
import 'distinguish.dart';
import 'study_word.dart';
import 'package:flutter_prj/common/http.dart';


class WordSerializer {
  WordSerializer();

  String _name;
  String name = '';
  String voiceUs = '';
  String voiceUk = '';
  String audioUsMan = '';
  String audioUsWoman = '';
  String audioUkMan = '';
  String audioUkWoman = '';
  List<String> morph = [];
  List<String> tag = [];
  List<String> etyma = [];
  String origin = '';
  String shorthand = '';
  List<String> synonym = [];
  List<String> antonym = [];
  SingleFile image = SingleFile('image', FileType.image);
  SingleFile vedio = SingleFile('vedio', FileType.video);
  List<ParaphraseSerializer> paraphraseSet = [];
  List<SentencePatternSerializer> sentencePatternSet = [];
  List<GrammarSerializer> grammarSet = [];
  List<DistinguishSerializer> distinguishSet = [];
  List<StudyWordSerializer> studyWordSet = [];
  bool offstage = true;

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/api/dictionary/word/', data:data ?? toJson(), queries:queries, cache:cache);
    if(res != null) {
      var jsonObj = {'name': res.data['name'] ?? name};
      fromJson(jsonObj); // Only update primary member after create
    }
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/api/dictionary/word/$name/', data:data ?? toJson(), queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/api/dictionary/word/$name/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({String pk}) async {
    if(_name == null && pk == null) return true;
    if(pk != null) name = pk;
    var res = await Http().request(HttpType.DELETE, '/api/dictionary/word/$name/');
    /*
    if(paraphraseSet != null){paraphraseSet.forEach((e){e.delete();});}
    if(sentencePatternSet != null){sentencePatternSet.forEach((e){e.delete();});}
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    if(distinguishSet != null){distinguishSet.forEach((e){e.delete();});}
    if(studyWordSet != null){studyWordSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = _name == null ?
      await create(data:data, queries:queries, cache:cache) :
      await update(data:data, queries:queries, cache:cache);

    if(res) {
      await Future.forEach(paraphraseSet, (e) async {e.wordForeign = name; await e.save();});
      await Future.forEach(sentencePatternSet, (e) async {e.wordForeign = name; await e.save();});
      await Future.forEach(grammarSet, (e) async {e.wordForeign = name; await e.save();});
      await Future.forEach(distinguishSet, (e) async { await e.save();});
      await Future.forEach(studyWordSet, (e) async {e.word = name; await e.save();});
    }
    res = await uploadFile();
    return res;
  }

  WordSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? name : json['name'] as String;
    voiceUs = json['voiceUs'] == null ? voiceUs : json['voiceUs'] as String;
    voiceUk = json['voiceUk'] == null ? voiceUk : json['voiceUk'] as String;
    audioUsMan = json['audioUsMan'] == null ? audioUsMan : json['audioUsMan'] as String;
    audioUsWoman = json['audioUsWoman'] == null ? audioUsWoman : json['audioUsWoman'] as String;
    audioUkMan = json['audioUkMan'] == null ? audioUkMan : json['audioUkMan'] as String;
    audioUkWoman = json['audioUkWoman'] == null ? audioUkWoman : json['audioUkWoman'] as String;
    morph = json['morph'] == null
                ? morph
                : json['morph'].map<String>((e) => e as String).toList();
    tag = json['tag'] == null
                ? tag
                : json['tag'].map<String>((e) => e as String).toList();
    etyma = json['etyma'] == null
                ? etyma
                : json['etyma'].map<String>((e) => e as String).toList();
    origin = json['origin'] == null ? origin : json['origin'] as String;
    shorthand = json['shorthand'] == null ? shorthand : json['shorthand'] as String;
    synonym = json['synonym'] == null
                ? synonym
                : json['synonym'].map<String>((e) => e as String).toList();
    antonym = json['antonym'] == null
                ? antonym
                : json['antonym'].map<String>((e) => e as String).toList();
    image.url = json['image'] == null ? image.url : json['image'] as String;
    vedio.url = json['vedio'] == null ? vedio.url : json['vedio'] as String;
    paraphraseSet = json['paraphraseSet'] == null
                ? paraphraseSet
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    sentencePatternSet = json['sentencePatternSet'] == null
                ? sentencePatternSet
                : json['sentencePatternSet'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    grammarSet = json['grammarSet'] == null
                ? grammarSet
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    distinguishSet = json['distinguishSet'] == null
                ? distinguishSet
                : json['distinguishSet'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
    studyWordSet = json['studyWordSet'] == null
                ? studyWordSet
                : json['studyWordSet'].map<StudyWordSerializer>((e) => StudyWordSerializer().fromJson(e as Map<String, dynamic>)).toList();
    _name = name;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'voiceUs': voiceUs,
    'voiceUk': voiceUk,
    'morph': morph == null ? null : morph.map((e) => e).toList(),
    'tag': tag == null ? null : tag.map((e) => e).toList(),
    'etyma': etyma == null ? null : etyma.map((e) => e).toList(),
    'origin': origin,
    'shorthand': shorthand,
    'synonym': synonym == null ? null : synonym.map((e) => e).toList(),
    'antonym': antonym == null ? null : antonym.map((e) => e).toList(),
  }..removeWhere((k, v) => v==null);

  Future<bool> uploadFile() async {
    var jsonObj = {'name': name};
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    bool ret = true;
    if(formData.files.isNotEmpty) {
      ret = await update(data:formData);
      if(image.mptFile != null) image.mptFile = null;
      if(vedio.mptFile != null) vedio.mptFile = null;
    }
    return ret;
  }

  WordSerializer from(WordSerializer instance) {
    if(instance == null) return this;
    name = instance.name;
    voiceUs = instance.voiceUs;
    voiceUk = instance.voiceUk;
    audioUsMan = instance.audioUsMan;
    audioUsWoman = instance.audioUsWoman;
    audioUkMan = instance.audioUkMan;
    audioUkWoman = instance.audioUkWoman;
    morph = List.from(instance.morph);
    tag = List.from(instance.tag);
    etyma = List.from(instance.etyma);
    origin = instance.origin;
    shorthand = instance.shorthand;
    synonym = List.from(instance.synonym);
    antonym = List.from(instance.antonym);
    image.from(instance.image);
    vedio.from(instance.vedio);
    paraphraseSet = List.from(instance.paraphraseSet.map((e) => ParaphraseSerializer().from(e)).toList());
    sentencePatternSet = List.from(instance.sentencePatternSet.map((e) => SentencePatternSerializer().from(e)).toList());
    grammarSet = List.from(instance.grammarSet.map((e) => GrammarSerializer().from(e)).toList());
    distinguishSet = List.from(instance.distinguishSet.map((e) => DistinguishSerializer().from(e)).toList());
    offstage = instance.offstage;
    _name = instance._name;
    return this;
  }
}



