// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'word.dart';
import 'sentence.dart';
import 'user.dart';
import 'net_cache_config.dart';
import 'paraphrase.dart';
import 'cache_config.dart';
import 'relative_sentence.dart';
import 'grammar.dart';
part 'user.g.dart';

@JsonSerializable()
class UserSerializer {
    UserSerializer();

    num u_id = 0;
    String u_uname = '';
    String u_passwd = '';
    bool u_is_admin = false;
    String u_register_date = '';
    String u_name = '';
    bool u_gender = true;
    String u_birthday = '';
    num u_education = 0;
    String u_wechart = '';
    String u_qq = '';
    String u_email = '';
    String u_telephone = '';
    String u_status = '';

    factory UserSerializer.fromJson(Map<String,dynamic> json) => _$UserSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$UserSerializerToJson(this);
}
