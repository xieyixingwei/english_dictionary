// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';

class StudyPlanSerializer {
  StudyPlanSerializer();

  num _id;
  num id;
  num foreignUser;
  num onceWords = 0;
  num onceSentences = 0;
  num onceGrammers = 0;
  List<String> vocabularies = [];


  StudyPlanSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? null : json['foreignUser'] as num;
    onceWords = json['onceWords'] == null ? null : json['onceWords'] as num;
    onceSentences = json['onceSentences'] == null ? null : json['onceSentences'] as num;
    onceGrammers = json['onceGrammers'] == null ? null : json['onceGrammers'] as num;
    vocabularies = json['vocabularies'] == null
                ? []
                : json['vocabularies'].map<String>((e) => e as String).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'onceWords': onceWords,
    'onceSentences': onceSentences,
    'onceGrammers': onceGrammers,
    'vocabularies': vocabularies == null ? null : vocabularies.map((e) => e).toList(),
  };

  StudyPlanSerializer from(StudyPlanSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    onceWords = instance.onceWords;
    onceSentences = instance.onceSentences;
    onceGrammers = instance.onceGrammers;
    vocabularies = List.from(instance.vocabularies);
    _id = instance._id;
    return this;
  }
}


