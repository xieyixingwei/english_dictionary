import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;


// 首字母大写
String _capitalize(String str) => '${str[0].toUpperCase()}${str.substring(1)}';

enum JsonType {
  Map,
  List
}

String _jsonType(JsonType type) =>
  type == JsonType.Map ? 'Map<String, dynamic>' : 'List';

String _serializerType(String name) {
    name = name.indexOf('_') > 0
          ? name.split('_').map<String>((String e) => _capitalize(e)).toList().join('')
          : _capitalize(name);
  return '${name}Serializer';
}

class Member {
  String type;
  String name;
  String init;
  String serializer;
  JsonSerializer fatherSerializer;
  JsonSerializer typeSerializer;
  List<Member> membersForeignToMeOfTypeSerializer;
  bool isPrimary = false;
  bool isList = false;
  bool isForeign = false;
  JsonType jsonType;
  bool unFromJson = false;
  bool unToJson = false;

  Member(String key, dynamic value, this.fatherSerializer ,{JsonType jsonType=JsonType.Map}) {
    this.jsonType = jsonType;
    _parseKey(key);
    _parseValue(value);
  }

  void _parseKey(String key) {
    if(key.contains('@primary')) {
      key = key.replaceAll('@primary', '').trim();
      isPrimary = true;
    }
    if(key.contains('@foreign')) {
      key = key.replaceAll('@foreign', '').trim();
      isForeign = true;
    }

    unToJson = key.trim().startsWith('_');   // the member is not in toJson
    unFromJson = key.trim().startsWith('__'); // the member is not in fromJson
    name = _trim(key);
  }

  void _parseValue(dynamic value) {
    if(value is bool) {
      type = 'bool';
      init = value.toString();
    }
    else if(value is double) {
      type = 'double';
      init = value.toString();
    }
    else if(value is num) {
      type = 'num';
      init = value.toString();
    }
    else if(value is String) {
      if(value.contains('=null')) {
        init = null;
        type = value.split('=').first;
        if(isList == false) {
          isList = type.contains('List');
          type = type.replaceAll('List<', '').replaceAll('>', '');
        }
        if(type.startsWith('\$')) {
          serializer = type.substring(1);
          type = serializerType;
        }
      }
      else if(value.startsWith('\$[]')) {
        serializer = value.substring(3);
        type = serializerType;
        init = '[]';
        isList = true;
      }
      else if (value.startsWith('\$')) {
        serializer = value.substring(1);
        type = serializerType;
        init = '$type()';
      }
      else {
        type = 'String';
        init = '\'$value\'';
      }
    }
    else if(value is Map) {
      type = 'Map<String, dynamic>';
      init = '{}';
    }
    else if(value is List) {
      isList = true;
      if(value.length == 0) {
        init = '[]';
      }
      else {
        _parseValue(value.first);
        init = init != null ? '[]' : null;
      }
    }
  }

  String get serializerType => _serializerType(serializer);
  String get importSerializer => serializer == null ? '' : 'import \'$serializer.dart\';';
  String _trim(String val) => val.startsWith('_') ? _trim(val.substring(1)).trim() : val.trim();
  bool get typeIsSerializer => type.contains('Serializer');

  void linkForeign(List<JsonSerializer> serializers) {
    if(serializer == null) return;
    var tmp = serializers.where((e) => e.name == serializer).toList();
    typeSerializer = tmp != null && tmp.length == 1 ? tmp.first : null;

    if(isForeign) {
      type = typeSerializer.primaryMember.type;
      init = null;
    }
  }

  String get save {
    if(serializer == null) return null;
    if(typeSerializer == null) return null;
    if(isForeign) return null;
    if(typeSerializer.httpMethodsObj == null) return null;
    if(!typeSerializer.httpMethodsObj.hasSave) return null;
    membersForeignToMeOfTypeSerializer = typeSerializer.members.where((e) => e.isForeign ? e.serializer == fatherSerializer.name : false).toList();
    List<String>eForeignNames = membersForeignToMeOfTypeSerializer.map((e) => e.name).toList();
    String eAssignForeign = eForeignNames.map((e) => 'e.$e = res.${fatherSerializer.primaryMember.name};').toList().join(' ');
    return isList ? 'if($name != null){$name.forEach((e){$eAssignForeign e.save();});}' : 'if($name != null){$eAssignForeign $name.save();}';
  }

  String get delete {
    if(serializer == null) return null;
    if(typeSerializer == null) return null;
    if(isForeign) return null;
    if(typeSerializer.httpMethodsObj == null) return null;
    if(!typeSerializer.httpMethodsObj.hasDelete) return null;
    return isList ? 'if($name != null){$name.forEach((e){e.delete();});}' : 'if($name != null){$name.delete();}';
  }

  String get member {
    String _type = isList ? 'List<$type>' : type;
    String _init = init != null ? ' = $init' : '';
    return '$_type $name$_init;';
  }

  String get fromJson {
    if(unFromJson) return null; // ignore member which name start with '__'
    String jsonMember = jsonType == JsonType.Map ? 'json[\'$name\']' : 'json';
    String eFromJson = typeIsSerializer ? '$type().fromJson(e as Map<String, dynamic>)' : 'e as $type';
    String unListFromJson = typeIsSerializer ? 
"""$jsonMember == null
                ? null
                : $type().fromJson($jsonMember as Map<String, dynamic>)""" : '$jsonMember as $type';

    String listFromJson = 
"""$jsonMember == null
                ? []
                : $jsonMember.map<$type>((e) => $eFromJson).toList()""";

    String memberFromJson = isList ? listFromJson : unListFromJson;
    return '$name = $memberFromJson';
  }

  String get toJson {
    if(unToJson) return null; // ignore member which name start with '_'
    String eToJson = typeIsSerializer ? 'e.toJson()' : 'e';
    String unListToJson = typeIsSerializer ? '$name == null ? null : $name.toJson()' : '$name';
    String listToJson = '$name == null ? null : $name.map((e) => $eToJson).toList()';
    String memberToJson = isList ? listToJson : unListToJson;
    return jsonType == JsonType.Map ? '\'$name\': $memberToJson,' : '$memberToJson;';
  }
}


class HttpMethods {
  final JsonSerializer fatherSerializer;
  List methodsConfig = [];
  Map<String, dynamic> httpConfig;
  static const Map<String, String> methodMap = {
    'create': 'post',
    'update': 'put',
    'retrieve': 'get',
    'list': 'get',
    'delete': 'delete',
  };

  String get baseUrl => httpConfig['url'];
  String get httpPackage => httpConfig['http_package'];
  String get importHttpPackage => httpPackage != null ? 'import \'$httpPackage\';\n' : '';
  String get serializerType => fatherSerializer.serializerType;
  bool get hasSave => methodsConfig.where((e) => e['name'] == 'save').length > 0;
  bool get hasUpdate => methodsConfig.where((e) => e['name'] == 'update').length > 0;
  bool get hasDelete => methodsConfig.where((e) => e['name'] == 'delete').length > 0;

  HttpMethods(this.fatherSerializer, this.httpConfig) {
    methodsConfig = httpConfig['methods'];
  }

  List<String> get methods =>
    methodsConfig.map((e) {
      String methodName = e['name'];
      if(methodName == "save") {
        String update = hasUpdate ? 'await this.update(data:data, queryParameters:queryParameters, update:update, cache:cache)' : 'null';
        return
"""
  Future<$serializerType> save({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    $serializerType res = ${fatherSerializer.primaryMember.name} == null
                               ? await this.create(data:data, queryParameters:queryParameters, update:update, cache:cache)
                               : $update;
    ${fatherSerializer.membersSave}
    return res;
  }
""";
      }

      String requestUrl = baseUrl + (e["url"] != null ? e["url"] : '');
      String requestType = e["requst"] != null ? e["requst"] : methodMap[methodName];
      String data = 'data:(data == null ? this.toJson() : data)';
      String queryParameters = 'queryParameters:queryParameters';
      String cache = 'cache:cache';

      if(requestType == "post") {
        return
"""
  Future<$serializerType> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '$requestUrl', $data, $queryParameters, $cache);
    return update ? this.fromJson(res.data) : $serializerType.newFromJson(res.data);
  }
""";
      }
      else if(requestType == "put") {
        return
"""
  Future<$serializerType> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '$requestUrl', $data, $queryParameters, $cache);
    return update ? this.fromJson(res.data) : $serializerType.newFromJson(res.data);
  }
""";
      }else if(methodName == "list") {
        return
"""
  static Future<List<$serializerType>> list({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '$requestUrl', $queryParameters, $cache);
    return res.data.map<$serializerType>((e) => $serializerType().fromJson(e)).toList();
  }
""";
      }
      else if(requestType == "get") {
        return
"""
  Future<$serializerType> $methodName({Map<String, dynamic> queryParameters, bool update=false, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, '$requestUrl', $queryParameters, $cache);
    return update ? this.fromJson(res.data) : $serializerType.newFromJson(res.data);
  }
""";
      }
      else if(requestType == "delete") {
        return
"""
  Future<bool> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    if(${fatherSerializer.primaryMember.name} == null) return false;
    var res = await Http().request(HttpType.DELETE, '$requestUrl', $data, $queryParameters, $cache);
    /*
    ${fatherSerializer.membersDelete}
    */
    return res != null ? res.statusCode == 204 : false;
  }
""";
      }
    }).toList();
}

class JsonSerializer {
  List<Member> members = [];
  HttpMethods httpMethodsObj;
  String name;
  String serializerType;
  JsonType jsonType = JsonType.Map;
  String jsonSrc;

  JsonSerializer(this.name, this.jsonSrc) {
    var obj;
    try{
      obj = json.decode(jsonSrc);
    } catch(e) {
      print('****** Parse Json Error: $e');
      return;
    }

    if(obj['__name__'] != null) {
      name = obj['__name__'].trim();
      obj.remove('__name__');
    }

    serializerType = _serializerType(name);

    Map<String, dynamic> http;
    if(obj['__http__'] != null) {
      http = obj['__http__'];
      obj.remove('__http__');
    }

    if(obj['__json__'] != null) {
      Map<String, dynamic> jsonConfig = obj['__json__'];
      obj.remove('__json__');

      jsonType = jsonConfig['type'] is List ? JsonType.List : jsonType;

      String key = jsonConfig['member'].keys.first;
      dynamic value = jsonConfig['member'].values.first;
      members.add(Member(key, value, this, jsonType: jsonType));
    }
    else {
      obj.forEach((String key, dynamic value) {
        members.add(Member(key, value, this));
      });
    }

    if(http != null)
      httpMethodsObj = HttpMethods(this, http);
  }

  void linkForeign(List<JsonSerializer> serializers) => members.forEach((e) => e.linkForeign(serializers));
  String get membersSave => members.map((e) => e.save).toList().where((e) => e != null).join('\n    ');
  String get membersDelete => members.map((e) => e.delete).toList().where((e) => e != null).join('\n    ');
  Member get primaryMember => members.firstWhere((element) => element.isPrimary);
  String get fromJsonMembers => members.map((e) => e.fromJson).toList().where((e) => e != null).join(';\n    ');

  String get fromJson =>
"""
  $serializerType fromJson(${_jsonType(jsonType)} json) {
    $fromJsonMembers;
    return this;
  }""";

  String get newFromJsonMembers => members.map((e) => e.fromJson).toList().where((e) => e != null).join('\n      ..');
  String get newFromJson =>
"""
  factory $serializerType.newFromJson(${_jsonType(jsonType)} json) {
    return $serializerType()
      ..$newFromJsonMembers;
  }""";

  String get toJsonMembers => members.map((e) => e.toJson).toList().where((e) => e != null).join('\n    ');

  String get toJson =>
    jsonType == JsonType.Map ?
"""
  Map<String, dynamic> toJson() => <String, dynamic>{
    $toJsonMembers
  };""" :
"""
  List toJson() =>
    $toJsonMembers""";

  String get importSerializers => members.map((e) => e.importSerializer).toSet().join('\n');
  String get importHttpPackage => httpMethodsObj != null ? httpMethodsObj.importHttpPackage : '';
  String get serializerMembers => members.map((e) => e.member).toList().join('\n  ');
  String get httpMethods => httpMethodsObj != null ? httpMethodsObj.methods.join('\n') : '';

  String get content =>
"""
// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
$importSerializers
$importHttpPackage

class $serializerType {
  $serializerType();

  $serializerMembers

$httpMethods
$fromJson

$newFromJson

$toJson
}
""";

  void save(String distPath) async {
    await File(path.join(distPath, '$name.dart')).writeAsString(content);
  }
}


class JsonSerializeTool {
  String srcDir = './jsons';
  String distDir = './serializers';
  String indexFile = 'index.dart';
  List<JsonSerializer> serializers = [];

  Future<bool> _handleArgs(List<String> args) async {
    int index = args.indexOf('-src');
    if(index != -1) {
      srcDir = path.normalize(args[index + 1]);
    }

    index = args.indexOf('-dist');
    if(index != -1) {
      distDir = path.normalize(args[index + 1]);
    }

    Directory _distDir = Directory(distDir);
    if(!await _distDir.exists()) {
      _distDir.create(recursive:true);
    }

    indexFile = path.join(distDir, indexFile);
    if(await File(indexFile).exists()) {
      File(indexFile).delete();
    }

    return true;
  }

  List<String> _jsons(String src) {
    List<String> ret = [];
    String left;
    String right;
    int count = 0;
    String one = '';
    src.split('').forEach((e) {
      if(left == null && '{['.contains(e)) {
        left = e;
        right = left == '{' ? '}' : ']';
      }
      if(left != null && e == left) count++;
      if(right != null && e == right) count--;
      one += e;
      if(left != null && count == 0) {
        ret.add(one);
        one = '';
        left = null;
        right = null;
      }
    });
    return ret;
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

  void run(List<String> args) async {
    await _handleArgs(args);
    List<FileSystemEntity> items = Directory(srcDir).listSync();

    for(FileSystemEntity item in items) {
      if(item is Directory) continue; // ignore directory
      if('.json' != path.extension(item.path)) continue; // ignore the not json files
      if(path.basename(item.path).startsWith('_')) continue; // ignore the json files which begin with '_'

      List<String> lines = await File(item.path).readAsLines();
      List<String> jsonsSrc = _jsons(_removeComments(lines));
      jsonsSrc.forEach((e) =>
        serializers.add(JsonSerializer(path.basenameWithoutExtension(item.path), e))
      );
    }

    serializers.forEach((e) => e.linkForeign(serializers));
    print(serializers.length);
    serializers.forEach(
      (e) {
        e.save(distDir);
        File(indexFile).writeAsStringSync('export \'${e.name}.dart\';\n', mode: FileMode.append, flush: true);
      } 
    );
  }
}

void main(List<String> args) {
  var js = JsonSerializeTool();
  js.run(args);
}
