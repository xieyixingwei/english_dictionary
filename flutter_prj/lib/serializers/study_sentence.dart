// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************

import 'dart:convert';

class StudySentenceSerializer {
  StudySentenceSerializer();

  num _id;
  num id = 0;
  num foreignUser;
  List<num> foreignSentence = [];
  List<String> vocabularies = [];
  num familiarity = 0;
  List<String> learnRecord = [];
  bool inplan = false;
  bool isFavorite = false;
  String comments = '';
  num repeats = 0;
  List<String> newWords = [];


  StudySentenceSerializer fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'] as num;
    foreignUser = json['foreignUser'] == null ? null : json['foreignUser'] as num;
    foreignSentence = json['foreignSentence'] == null
                ? []
                : json['foreignSentence'].map<num>((e) => e as num).toList();
    vocabularies = json['vocabularies'] == null
                ? []
                : json['vocabularies'].map<String>((e) => e as String).toList();
    familiarity = json['familiarity'] == null ? null : json['familiarity'] as num;
    learnRecord = json['learnRecord'] == null
                ? []
                : json['learnRecord'].map<String>((e) => e as String).toList();
    inplan = json['inplan'] == null ? null : json['inplan'] as bool;
    isFavorite = json['isFavorite'] == null ? null : json['isFavorite'] as bool;
    comments = json['comments'] == null ? null : json['comments'] as String;
    repeats = json['repeats'] == null ? null : json['repeats'] as num;
    newWords = json['newWords'] == null
                ? []
                : json['newWords'].map<String>((e) => e as String).toList();
    _id = id;
    return this;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'foreignUser': foreignUser,
    'foreignSentence': foreignSentence == null ? null : foreignSentence.map((e) => e).toList(),
    'vocabularies': vocabularies == null ? null : vocabularies.map((e) => e).toList(),
    'familiarity': familiarity,
    'learnRecord': learnRecord == null ? null : learnRecord.map((e) => e).toList(),
    'inplan': inplan,
    'isFavorite': isFavorite,
    'comments': comments,
    'repeats': repeats,
    'newWords': newWords == null ? null : newWords.map((e) => e).toList(),
  };

  StudySentenceSerializer from(StudySentenceSerializer instance) {
    if(instance == null) return this;
    id = instance.id;
    foreignUser = instance.foreignUser;
    foreignSentence = List.from(instance.foreignSentence);
    vocabularies = List.from(instance.vocabularies);
    familiarity = instance.familiarity;
    learnRecord = List.from(instance.learnRecord);
    inplan = instance.inplan;
    isFavorite = instance.isFavorite;
    comments = instance.comments;
    repeats = instance.repeats;
    newWords = List.from(instance.newWords);
    _id = instance._id;
    return this;
  }
}


