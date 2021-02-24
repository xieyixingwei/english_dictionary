import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;


class JsonSerializer {
  String _srcDir = './jsons';
  String _distDir = './serializers';
  String _indexFile = 'index.dart';
  List<String> _relatedSerializers = [];

  static const String _serializerTemplate = """
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
%importRelatedSerializers
part '%name.g.dart';

@JsonSerializable()
class %Name {
    %Name();

    %members

    factory %Name.fromJson(Map<String,dynamic> json) => _\$%NameFromJson(json);
    Map<String, dynamic> toJson() => _\$%NameToJson(this);
}
""";

  static const String _serializerTemplate_g = """
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
part of '%name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

%Name _\$%NameFromJson(Map<String, dynamic> json) {
  return %Name()
    %serializerMembers
}

Map<String, dynamic> _\$%NameToJson(%Name instance) => <String, dynamic>{
    %jsonMembers
};
""";

  void _handleArgs(List<String> args) async {
    int index = args.indexOf('-src');
    if(index != -1) {
      _srcDir = path.normalize(args[index + 1]);
    }
    index = args.indexOf('-dist');
    if(index != -1) {
      _distDir = path.normalize(args[index + 1]);
    }

    Directory distDir = Directory(_distDir);
    if(!await distDir.exists()) {
      distDir.create(recursive:true);
    }

    _indexFile = path.join(_distDir, _indexFile);
    if(await File(_indexFile).exists()) {
      File(_indexFile).delete();
    }
  }

  String _removeComments(List<String> lines) {
    String content = '';
    lines.forEach(
      (String line) {
        int pos = line.indexOf('//'); // comment char is '//'
        if(pos != -1) {
          line = line.substring(0, pos);
        }
        content += line + '\n';
      }
    );
    return content;
  }

  // 首字母大写
  String _capitalize(String str) => '${str[0].toUpperCase()}${str.substring(1)}';

  String _serializerClassName(String name) {
      name = name.indexOf('_') > 0
           ? name.split('_').map<String>((String e) => _capitalize(e)).toList().join('')
           : _capitalize(name);
    return '${name}Serializer';
  }

  bool _isSerializer(String type) => type.contains('Serializer');

  void _addRelatedSerializer(String name) {
    if(!_relatedSerializers.contains(name))
      _relatedSerializers.add(name);
  }

  Map<String, String> _typeValue(dynamic value) {
    Map<String, String> result = {
      'type': '',
      'value': '',
    };
    if(value is bool) {
      result['type'] = 'bool';
      result['value'] = value.toString();
    }
    else if(value is double) {
      result['type'] = 'double';
      result['value'] = value.toString();
    }
    else if(value is num) {
      result['type'] = 'num';
      result['value'] = value.toString();
    }
    else if(value is String) {
      if(value.startsWith('\$[]')) {
        String relatedSerializer = value.substring(3);
        _addRelatedSerializer(relatedSerializer);
        String serializerClassName = _serializerClassName(relatedSerializer);
        result['type'] = 'List<$serializerClassName>';
        result['value'] = '[]';
      }
      else if (value.startsWith('\$')) {
        String relatedSerializer = value.substring(1);
        _addRelatedSerializer(relatedSerializer);
        String serializerClassName = _serializerClassName(relatedSerializer);
        result['type'] = serializerClassName;
        result['value'] = '$serializerClassName()';
      }
      else {
        result['type'] = 'String';
        result['value'] = '\'$value\'';
      }
    }
    else if(value is Map) {
      result['type'] = 'Map<String, dynamic>';
      result['value'] = '{}';
    }
    else if(value is List) {
      Map<String, String> res = _typeValue(value[0]);
      result['type'] = 'List<${res['type']}>';
      result['value'] = '[]';
    }
    return result;
  }

  String _member(String key, dynamic value) {
    String name = key.startsWith('_') ? key.substring(1) : key; // remove the '_' prefix
    Map<String, String> res = _typeValue(value);
    return '${res['type']} ${name} = ${res['value']};';
  }

  String _serializerMember(String key, dynamic value) {
    String name = key;
    if(name.startsWith('_')) return null; // ignore member which name start with '_'
    Map<String, String> res = _typeValue(value);
    String type = res['type'];

    if(type.startsWith('List')) {
      type = type.replaceAll('List<', '').replaceAll('>', '');
      if(_isSerializer(type)) {
        return '..$name = json[\'$name\'] == null\n' +
               '        ? null\n' +
               '        : json[\'$name\'].map<$type>((e) => $type.fromJson(e as Map<String, dynamic>)).toList()';
      }
      else {
        return '..$name = json[\'$name\'] == null\n' + 
               '        ? null\n' +
               '        : json[\'$name\'].map<$type>((e) => e as $type).toList()';
      }
    }
    else if(_isSerializer(type)) {
      return '..$name = json[\'$name\'] == null\n' +
             '        ? null\n' +
             '        : $type.fromJson(json[\'$name\'] as Map<String, dynamic>)';
    }
    else
      return '..$name = json[\'$name\'] as $type';
  }

  String _jsonMember(String key, dynamic value) {
    String name = key;
    if(name.startsWith('_')) return null; // ignore member which name start with '_'
    return '\'$name\': instance.$name';
  }

 void _generateSerializerFromJson(String name, Map<String, dynamic> obj) async {
   List<String> members = [];
   List<String> serializerMembers = [];
   List<String> jsonMembers = [];

   obj.forEach((String key, dynamic value) {
            members.add(_member(key, value));
            String tmp = _serializerMember(key, value);
            if(tmp != null) serializerMembers.add(tmp);
            tmp = _jsonMember(key, value);
            if(tmp != null) jsonMembers.add(tmp);
   });

  String importRelatedSerializers = _relatedSerializers.map<String>((e) => 'import \'$e.dart\';').toList().join('\n');
  String serializerClassName = _serializerClassName(name);

  String content = _serializerTemplate.replaceAll('%importRelatedSerializers', importRelatedSerializers)
                                      .replaceAll('%name', name)
                                      .replaceAll('%Name', serializerClassName)
                                      .replaceAll('%members', members.join('\n    '));
  await File(path.join(_distDir, '$name.dart')).writeAsString(content);

  content = _serializerTemplate_g.replaceAll('%name', name)
                                 .replaceAll('%Name', serializerClassName)
                                 .replaceAll('%serializerMembers', serializerMembers.join('\n    ') + ';')
                                 .replaceAll('%jsonMembers', jsonMembers.join(',\n    '));
  await File(path.join(_distDir, '$name.g.dart')).writeAsString(content);

  File(_indexFile).writeAsStringSync('export \'$name.dart\';\n', mode: FileMode.append, flush: true);
 }

  void run(List<String> args) {
    _handleArgs(args);

    Directory(_srcDir).list().listen(
      (FileSystemEntity entity) async {
        if('.json' != path.extension(entity.path)) return;
        if(path.basename(entity.path).startsWith('_')) return;
        List<String> lines = await File(entity.path).readAsLines();
        Map<String, dynamic> obj = json.decode(_removeComments(lines), );
        _relatedSerializers.clear();
        _generateSerializerFromJson(path.basenameWithoutExtension(entity.path), obj);
      }
    );
  }
}

void main(List<String> args) {
  var js = JsonSerializer();
  js.run(args);
}
