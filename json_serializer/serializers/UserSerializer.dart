
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'Person';

part 'UserSerializer.g.dart';

@JsonSerializable()
class UserSerializer {
    UserSerializer();

    String name = John Smith;
    double height = 175.8;
    num age = 22;
    String email = john@example.com;
    List<String> likes = [];
    Map class = {};
    Person mother = Person();
    List<Person> friends = [];

    factory UserSerializer.fromJson(Map<String,dynamic> json) => _$UserSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$UserSerializerToJson(this);
}
