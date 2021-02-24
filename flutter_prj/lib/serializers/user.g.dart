// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerializer _$UserSerializerFromJson(Map<String, dynamic> json) {
  return UserSerializer()
    ..u_id = json['u_id '] as num
    ..u_uname = json['u_uname '] as String
    ..u_passwd = json['u_passwd '] as String
    ..u_is_admin = json['u_is_admin '] as bool
    ..u_register_date = json['u_register_date '] as String
    ..u_name = json['u_name '] as String
    ..u_gender = json['u_gender '] as bool
    ..u_birthday = json['u_birthday '] as String
    ..u_education = json['u_education '] as num
    ..u_wechart = json['u_wechart '] as String
    ..u_qq = json['u_qq '] as String
    ..u_email = json['u_email '] as String
    ..u_telephone = json['u_telephone '] as String
    ..u_status = json['u_status '] as String;
}

Map<String, dynamic> _$UserSerializerToJson(UserSerializer instance) => <String, dynamic>{
    'u_id': instance.u_id,
    'u_uname': instance.u_uname,
    'u_passwd': instance.u_passwd,
    'u_is_admin': instance.u_is_admin,
    'u_register_date': instance.u_register_date,
    'u_name': instance.u_name,
    'u_gender': instance.u_gender,
    'u_birthday': instance.u_birthday,
    'u_education': instance.u_education,
    'u_wechart': instance.u_wechart,
    'u_qq': instance.u_qq,
    'u_email': instance.u_email,
    'u_telephone': instance.u_telephone,
    'u_status': instance.u_status
};
