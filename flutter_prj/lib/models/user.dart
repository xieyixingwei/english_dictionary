import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num u_id;
    String u_uname;
    String u_passwd;
    bool u_is_admin;
    String u_register_date;
    String u_name;
    bool u_gender;
    String u_birthday;
    num u_education;
    String u_wechart;
    String u_qq;
    String u_email;
    String u_telephone;
    String u_status;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
