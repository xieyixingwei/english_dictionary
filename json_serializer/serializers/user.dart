
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
import 'person.dart';
part 'user.g.dart';

@JsonSerializable()
class UserSerializer {
    UserSerializer();

    String name = "John Smith";
    double height = 175.8;
    num age = 22;
    String email = "john@example.com";
    List<PersonSerializer> likes = [PersonSerializer()];
    Map<String, dynamic> grade = {};
    PersonSerializer mother = PersonSerializer();
    List<PersonSerializer> friends = [];

    factory UserSerializer.fromJson(Map<String,dynamic> json) => _$UserSerializerFromJson(json);
    Map<String, dynamic> toJson() => _$UserSerializerToJson(this);
}
