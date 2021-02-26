// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
import 'sentence_tags.dart';
import 'package:flutter_prj/common/http.dart';


class ListSentenceTagsSerializer {
  ListSentenceTagsSerializer();

  List<SentenceTagsSerializer> tags = [];

  Future<ListSentenceTagsSerializer> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '/dictionary/sentencetags/', queryParameters:queryParameters, cache:cache);
    return this.fromJson(res.data);
  }

  ListSentenceTagsSerializer fromJson(List<Map<String, dynamic>> json) {
    tags = json == null
                  ? null
                  : json.map<SentenceTagsSerializer>((e) => SentenceTagsSerializer().fromJson(e)).toList();
    return this;
  }

  List<Map<String, dynamic>> toJson() => tags.map<Map<String, dynamic>>((e) => e.toJson()).toList();
}
