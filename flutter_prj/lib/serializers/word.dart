// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';
import 'single_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'paraphrase.dart';
import 'sentence_pattern.dart';
import 'grammar.dart';
import 'distinguish.dart';
import 'package:flutter_prj/common/http.dart';


class WordSerializer {
  WordSerializer();

  String _name;
  String name = '';
  String voiceUs = '';
  String voiceUk = '';
  String audioUsMan;
  String audioUsWoman;
  String audioUkMan;
  String audioUkWoman;
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

  Future<bool> create({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '/dictionary/word/', data:data ?? _formData, queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> update({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '/dictionary/word/$name/', data:data ?? _formData, queries:queries, cache:cache);
    return res != null;
  }

  Future<bool> retrieve({Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/word/$name/', queries:queries, cache:cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }

  Future<bool> delete({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(_name == null) return true;
    var res = await Http().request(HttpType.DELETE, '/dictionary/word/$name/', data:data ?? _formData, queries:queries, cache:cache);
    /*
    if(paraphraseSet != null){paraphraseSet.forEach((e){e.delete();});}
    if(sentencePatternSet != null){sentencePatternSet.forEach((e){e.delete();});}
    if(grammarSet != null){grammarSet.forEach((e){e.delete();});}
    if(distinguishSet != null){distinguishSet.forEach((e){e.delete();});}
    */
    return res != null ? res.statusCode == 204 : false;
  }

  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(_name == null) {
      var clone = WordSerializer().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      name = clone.name;
      if(paraphraseSet != null){await Future.forEach(paraphraseSet, (e) async {e.wordForeign = name; await e.save();});}
      if(sentencePatternSet != null){await Future.forEach(sentencePatternSet, (e) async {e.wordForeign = name; await e.save();});}
      if(grammarSet != null){await Future.forEach(grammarSet, (e) async {e.wordForeign = name; await e.save();});}
      if(distinguishSet != null){await Future.forEach(distinguishSet, (e) async { await e.save();});}
      res = await retrieve();
    } else {
      res = await update(data:data, queries:queries, cache:cache);
      if(paraphraseSet != null){await Future.forEach(paraphraseSet, (e) async {e.wordForeign = name; await e.save();});}
      if(sentencePatternSet != null){await Future.forEach(sentencePatternSet, (e) async {e.wordForeign = name; await e.save();});}
      if(grammarSet != null){await Future.forEach(grammarSet, (e) async {e.wordForeign = name; await e.save();});}
      if(distinguishSet != null){await Future.forEach(distinguishSet, (e) async { await e.save();});}
    }
    return res;
  }

  WordSerializer fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'] as String;
    voiceUs = json['voiceUs'] == null ? null : json['voiceUs'] as String;
    voiceUk = json['voiceUk'] == null ? null : json['voiceUk'] as String;
    audioUsMan = json['audioUsMan'] == null ? null : json['audioUsMan'] as String;
    audioUsWoman = json['audioUsWoman'] == null ? null : json['audioUsWoman'] as String;
    audioUkMan = json['audioUkMan'] == null ? null : json['audioUkMan'] as String;
    audioUkWoman = json['audioUkWoman'] == null ? null : json['audioUkWoman'] as String;
    morph = json['morph'] == null
                ? []
                : json['morph'].map<String>((e) => e as String).toList();
    tag = json['tag'] == null
                ? []
                : json['tag'].map<String>((e) => e as String).toList();
    etyma = json['etyma'] == null
                ? []
                : json['etyma'].map<String>((e) => e as String).toList();
    origin = json['origin'] == null ? null : json['origin'] as String;
    shorthand = json['shorthand'] == null ? null : json['shorthand'] as String;
    synonym = json['synonym'] == null
                ? []
                : json['synonym'].map<String>((e) => e as String).toList();
    antonym = json['antonym'] == null
                ? []
                : json['antonym'].map<String>((e) => e as String).toList();
    image.url = json['image'] == null ? null : json['image'] as String;
    vedio.url = json['vedio'] == null ? null : json['vedio'] as String;
    paraphraseSet = json['paraphraseSet'] == null
                ? []
                : json['paraphraseSet'].map<ParaphraseSerializer>((e) => ParaphraseSerializer().fromJson(e as Map<String, dynamic>)).toList();
    sentencePatternSet = json['sentencePatternSet'] == null
                ? []
                : json['sentencePatternSet'].map<SentencePatternSerializer>((e) => SentencePatternSerializer().fromJson(e as Map<String, dynamic>)).toList();
    grammarSet = json['grammarSet'] == null
                ? []
                : json['grammarSet'].map<GrammarSerializer>((e) => GrammarSerializer().fromJson(e as Map<String, dynamic>)).toList();
    distinguishSet = json['distinguishSet'] == null
                ? []
                : json['distinguishSet'].map<DistinguishSerializer>((e) => DistinguishSerializer().fromJson(e as Map<String, dynamic>)).toList();
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
  };
  FormData get _formData {
    var jsonObj = toJson();
    jsonObj['morph'] = json.encode(jsonObj['morph']);
    jsonObj['tag'] = json.encode(jsonObj['tag']);
    jsonObj['etyma'] = json.encode(jsonObj['etyma']);
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    if(image.mptFile != null) formData.files.add(image.file);
    if(vedio.mptFile != null) formData.files.add(vedio.file);
    return formData;
  }

  WordSerializer from(WordSerializer instance) {
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
    _name = instance._name;
    return this;
  }
}


