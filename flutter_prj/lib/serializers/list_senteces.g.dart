// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of 'list_senteces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSentecesSerializer _$ListSentecesSerializerFromJson(Map<String, dynamic> json) {
  return ListSentecesSerializer()
    ..count = json['count'] as num
    ..next = json['next'] as String
    ..previous = json['previous'] as String
    ..results = json['results'] == null
        ? null
        : json['results'].map<SentenceSerializer>((e) => SentenceSerializer.fromJson(e as Map<String, dynamic>)).toList();
}

Map<String, dynamic> _$ListSentecesSerializerToJson(ListSentecesSerializer instance) => <String, dynamic>{
    'count': instance.count,
    'next': instance.next,
    'previous': instance.previous,
    'results': instance.results
};
