import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;


// 首字母大写
String _capitalize(String str) => '${str[0].toUpperCase()}${str.substring(1)}';

enum JsonType {
  Map,
  List
}

enum ForeignType {
  Non,
  Foreign,
  ManyToMany
}

String _jsonType(JsonType type) =>
  type == JsonType.Map ? 'Map<String, dynamic>' : 'List';

String _serializerType(String name) {
  name = name.trim();
  name = name.indexOf('_') > 0
        ? name.split('_').map<String>((String e) => _capitalize(e)).toList().join('')
        : _capitalize(name);
  return '${name}Serializer';
}

bool _isSerializerType(String type) => type.contains('Serializer');

class Member {
  JsonSerializeTool serializeTool;
  String name;  // is the name of member
  String _unListType;  // is the type of member(Exclude List), eg: bool, num, double, String, Map, NameSerializer
  String _init;  // is the initial value of member
  String serializerJsonName;
  JsonSerializer fatherSerializer;
  List<Member> membersForeignToMeOfTypeSerializer;
  bool isPrimary = false;
  bool isList = false;
  bool isMap = false;
  ForeignType foreign = ForeignType.Non;
  JsonType jsonType;
  bool unFromJson = false;
  bool unToJson = false;
  bool isFileType =false;

  Member(String key, dynamic value, this.fatherSerializer, this.serializeTool, {JsonType jsonType=JsonType.Map}) {
    this.jsonType = jsonType;
    _parseKey(key);
    _parseValue(value);
  }

  void _parseKey(String key) {
    if(key.contains('@primary')) {
      key = key.replaceAll('@primary', '').trim();
      isPrimary = true;
    }

    if(key.contains('@foreign_manytomany')) {
      key = key.replaceAll('@foreign_manytomany', '').trim();
      foreign = ForeignType.ManyToMany;
    } else if(key.contains('@foreign')) {
      key = key.replaceAll('@foreign', '').trim();
      foreign = ForeignType.Foreign;
    }

    unToJson = key.trim().startsWith('_');   // the member is not in toJson
    unFromJson = key.trim().startsWith('__'); // the member is not in fromJson
    name = _trim(key);
  }

  void _parseValue(dynamic value) {
    if(value is bool) {
      _unListType = 'bool';
      _init = value.toString();
    }
    else if(value is double) {
      _unListType = 'double';
      _init = value.toString();
    }
    else if(value is num) {
      _unListType = 'num';
      _init = value.toString();
    }
    else if(value is String) {
      if(value.contains('=null')) {
        _init = null;
        _unListType = value.split('=').first;

        if(isList == false) {
          isList = _unListType.contains('List');
          _unListType = _unListType.replaceAll('List<', '').replaceAll('>', '');
        }

        if(_unListType.startsWith('\$')) {
          serializerJsonName = _unListType.substring(1).trim();
          _unListType = _serializerType(serializerJsonName);
        }
      }
      else if(value.startsWith('\$SingleFile')) {
        isFileType = true;
        _unListType = 'SingleFile';
        var filetype = value.split(' ').last.trim();
        _init = 'SingleFile(\'$name\', FileType.$filetype)';
        unToJson = true;
      }
      else if(value.startsWith('\$[]')) {
        serializerJsonName = value.substring(3).trim();
        _unListType = _serializerType(serializerJsonName);
        _init = '[]';
        isList = true;
      }
      else if (value.startsWith('\$')) {
        serializerJsonName = value.substring(1).trim();
        _unListType = _serializerType(serializerJsonName);
        _init = '$_unListType()';
      }
      else if (value == 'dynamic') {
        _unListType = 'dynamic';
        _init = null;
      }
      else {
        _unListType = 'String';
        _init = '\'$value\'';
      }
    }
    else if(value is Map) {
      _unListType = 'Map<String, dynamic>';
      _init = '{}';
      isMap = true;
    }
    else if(value is List) {
      isList = true;
      if(value.length == 0) {
        _unListType = 'dynamic';
        _init = '[]';
      }
      else {
        _parseValue(value.first);
        _init = _init != null ? '[]' : null;
      }
    }
  }

  // the type of foreign member is the type of foreign to Serializer'sprimary key 
  bool get isSerializerType => _isSerializerType(type);

  // the type of foreign member is not a Serializer and don't need import serializer
  String get importSerializer {
    List<String> import = [];
    if(isForeign || isForeignManyToMany) return '';
    if(serializerJsonName != null) import.add('import \'$serializerJsonName.dart\';');
    if(isFileType) import.add(SingleFileType.import);
    if(jsonEncode != null) import.add('import \'dart:convert\';');
    return import.join('\n');
  }

  String _trim(String val) => val.startsWith('_') ? _trim(val.substring(1)).trim() : val.trim();

  JsonSerializer get typeSerializer {
    try{
      return serializeTool.serializers.singleWhere((e) => e.jsonName == serializerJsonName, orElse: () => null);
    } catch(e) {
      print('*** ERROR: find more than one \'$serializerJsonName\', ${e.toString()}');
    }
    return null;
  }

  bool get isForeign => foreign == ForeignType.Foreign;
  bool get isForeignManyToMany => foreign == ForeignType.ManyToMany;
  String get unListType => (isForeignManyToMany || isForeign) ? typeSerializer.primaryMember.type : _unListType;
  String get type => isList ? 'List<$unListType>' : unListType;
  String get init => isForeignManyToMany ? '[]' : (isForeign ? (isList ? '[]' : null) : _init);

  String get save {
    if(!isSerializerType) return null;
    if(typeSerializer == null) return null;
    if(isForeign) return null;
    if(typeSerializer.httpMethodsObj == null) return null;
    if(!typeSerializer.httpMethodsObj.hasSave) return null;

    membersForeignToMeOfTypeSerializer = typeSerializer.members.where((e) => e.isForeign ? e.serializerJsonName == fatherSerializer.jsonName : false).toList();
    List<String>eForeignNames = membersForeignToMeOfTypeSerializer.map((e) => e.name).toList();
    String eAssignForeign = eForeignNames.map((e) => 'e.$e = ${fatherSerializer.primaryMember.name};').toList().join(' ');
    return isList ? 'if($name != null){await Future.forEach($name, (e) async {$eAssignForeign await e.save();});}' : 'if($name != null){$eAssignForeign await $name.save();}';
  }

  String get delete {
    if(!isSerializerType) return null;
    if(typeSerializer == null) return null;
    if(isForeign) return null;
    if(typeSerializer.httpMethodsObj == null) return null;
    if(!typeSerializer.httpMethodsObj.hasDelete) return null;
    return isList ? 'if($name != null){$name.forEach((e){e.delete();});}' : 'if($name != null){$name.delete();}';
  }

  String get member {
    String value = init != null ? ' = $init' : '';
    return '$type $name$value;';
  }

  String get fromJson {
    if(unFromJson) return null; // ignore member which name start with '__'
    String jsonMember = jsonType == JsonType.Map ? 'json[\'$name\']' : 'json';
    String type = isFileType ? 'String' : unListType;
    String eFromJson = isSerializerType ? '$type().fromJson(e as Map<String, dynamic>)' : 'e as $type';
    String unListFromJson = isSerializerType ? 
"""$jsonMember == null
                ? null
                : $unListType().fromJson($jsonMember as Map<String, dynamic>)""" : '$jsonMember == null ? null : $jsonMember as $type';

    String listFromJson = 
"""$jsonMember == null
                ? []
                : $jsonMember.map<$unListType>((e) => $eFromJson).toList()""";

    String memberFromJson = isList ? listFromJson : unListFromJson;
    return isFileType ? '$name.url = $memberFromJson' : '$name = $memberFromJson';
  }

  String get toJson {
    if(unToJson) return null; // ignore member which name start with '_'
    String eToJson = isSerializerType ? 'e.toJson()' : 'e';
    String unListToJson = isSerializerType ? '$name == null ? null : $name.toJson()' : '$name';
    String listToJson = '$name == null ? null : $name.map((e) => $eToJson).toList()';
    String memberToJson = isList ? listToJson : unListToJson;
    return jsonType == JsonType.Map ? '\'$name\': $memberToJson,' : '$memberToJson;';
  }

  String get from {
    String commonFrom = 'instance.$name';
    String listFrom = 'List.from($commonFrom)';
    String serializerFrom = '$unListType().from($commonFrom)';
    String listSerializerFrom = 'List.from(instance.$name.map((e) => $unListType().from(e)).toList())';
    String from = isList ? (isSerializerType ? listSerializerFrom : listFrom) : (isSerializerType ? serializerFrom : commonFrom);
    return isFileType ? '$name.from($from);' : '$name = $from;';
  }

  String get hidePrimaryMemberName => isPrimary ? '_$name' : null;
  String get hidePrimaryMember => isPrimary ? '$unListType $hidePrimaryMemberName;' : null;
  String get hidePrimaryMemberFromJson => isPrimary ? '$hidePrimaryMemberName = $name' : null;
  String get hidePrimaryMemberFrom => isPrimary ? '$hidePrimaryMemberName = instance.$hidePrimaryMemberName;' : null;

  String get jsonEncode => (isForeign || isForeignManyToMany || unToJson) ? null : (isList || isMap ? 'jsonObj[\'$name\'] = json.encode(jsonObj[\'$name\']);' : null);
  String get addToFormData => isFileType ? 'if($name.mptFile != null) formData.files.add($name.file);' : null;
}


class SingleFileType {
  static bool saved = false;
  static final String fileName = 'single_file';
  static final String import = 'import \'$fileName.dart\';\nimport \'package:file_picker/file_picker.dart\';\nimport \'package:dio/dio.dart\';';
  final String content = """
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';


class SingleFile {
  SingleFile(String field, FileType type)
    : this.field = field, this.type = type;

  final FileType type;
  final String field;
  String url;
  MultipartFile mptFile;

  MapEntry<String, MultipartFile> get file => MapEntry(field, mptFile);

  SingleFile from(SingleFile instance) {
    url = instance.url;
    mptFile = instance.mptFile;
    return this;
  }

  Future<bool> pick() async {
    var result = await FilePicker.platform.pickFiles(type: type, withReadStream: true);
    if (result == null) return false;
    var objFile = result.files.single;
    // 注意: 需要使用 'package::dio/dio.dart';中的 MultipartFile
    mptFile = MultipartFile(objFile.readStream, objFile.size, filename: objFile.name);
    return true;
  }
}
""";

  Future save(String distPath) async {
    if(saved == false) {
      await File(path.join(distPath, '$fileName.dart')).writeAsString(content);
      saved = true;
    }
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
  String get importHttpPackage => httpPackage != null ? '\nimport \'$httpPackage\';\n' : '';
  String get serializerType => fatherSerializer.serializerTypeName;
  bool get hasSave => methodsConfig.indexWhere((e) => e['name'] == 'save') != -1;
  bool get hasUpdate => methodsConfig.indexWhere((e) => e['name'] == 'update') != -1;
  bool get hasDelete => methodsConfig.indexWhere((e) => e['name'] == 'delete') != -1;

  HttpMethods(this.fatherSerializer, this.httpConfig) {
    methodsConfig = httpConfig['methods'];
  }

  List<String> get methods =>
    methodsConfig.map((e) {
      String queryset = e['filter'] == true ? '(queries != null && filter.queryset != null) ? queries.addAll(filter.queryset) : queries = filter.queryset;\n    ' : '';
      String methodName = e['name'];

      if(methodName == 'save') {
        String saveForeign = fatherSerializer.membersSave.isNotEmpty ? '\n      ${fatherSerializer.membersSave}' : '';
        String update = hasUpdate ? 'res = await update(data:data, queries:queries, cache:cache);' : '';
        String create = fatherSerializer.membersSave.isNotEmpty ? 
"""var clone = $serializerType().from(this); // create will update self, maybe refresh the member of self.
      res = await clone.create(data:data, queries:queries, cache:cache);
      if(res == false) return false;
      ${fatherSerializer.primaryMember.name} = clone.${fatherSerializer.primaryMember.name};
      ${fatherSerializer.membersSave}
      res = await retrieve();""" : """res = await create(data:data, queries:queries, cache:cache);""";
        return
"""
  Future<bool> save({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    bool res = false;
    if(${fatherSerializer.primaryMember.hidePrimaryMemberName} == null) {
      $create
    } else {
      $update$saveForeign
    }
    return res;
  }
""";
      }

      String requestUrl = baseUrl + (e["url"] != null ? e["url"] : '');
      String requestType = e["requst"] != null ? e["requst"] : methodMap[methodName];
      String data = fatherSerializer.hasFileType ? 'data:data ?? _formData' : 'data:data ?? toJson()';
      String queries = 'queries:queries';
      String cache = 'cache:cache';

      if(requestType == "post") {
        return
"""
  Future<bool> $methodName({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '$requestUrl', $data, $queries, $cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }
""";
      }
      else if(requestType == "put") {
        return
"""
  Future<bool> $methodName({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, '$requestUrl', $data, $queries, $cache);
    return res != null;
  }
""";
      }else if(methodName == "list") {
        return
"""
  static Future<List<$serializerType>> list({Map<String, dynamic> queries, bool cache=false}) async {
    ${queryset}var res = await Http().request(HttpType.GET, '$requestUrl', $queries, $cache);
    return res != null ? res.data.map<$serializerType>((e) => $serializerType().fromJson(e)).toList() : [];
  }
""";
      }
      else if(requestType == "get") {
        return
"""
  Future<bool> $methodName({Map<String, dynamic> queries, bool cache=false}) async {
    ${queryset}var res = await Http().request(HttpType.GET, '$requestUrl', $queries, $cache);
    if(res != null) fromJson(res.data);
    return res != null;
  }
""";
      }
      else if(requestType == "delete") {
        return
"""
  Future<bool> $methodName({dynamic data, Map<String, dynamic> queries, bool cache=false}) async {
    if(${fatherSerializer.primaryMember.name} == null) return true;
    var res = await Http().request(HttpType.DELETE, '$requestUrl', $data, $queries, $cache);
    /*
    ${fatherSerializer.membersDelete}
    */
    return res != null ? res.statusCode == 204 : false;
  }
""";
      }
    }).toList();
}

class Filter {
  final JsonSerializer fatherSerializer;
  String serializerJsonName;
  List<Map<String, String>> _filters = [];

  Filter(this.serializerJsonName, this.fatherSerializer, Map<String, dynamic> obj) {
    obj.forEach((String key, dynamic values) {
        key = key.trim();
        if(key == '__serializer__') {
          serializerJsonName = values.trim().startsWith('\$') ? values.trim().substring(1) : values.trim();
          return;
        }
        values.forEach((e) {
          e = e.trim();
          if(e == 'exact')
            _filters.add({'$key': '$key'});
          else if(e == 'icontains')
            _filters.add({'$key': '${key}__icontains'});
          else
            _filters.add({'$key': '${key}__$e'});
        });
      });
  }

  JsonSerializer get onSerializer => fatherSerializer.serializeTool.serializers.singleWhere((e) => e.jsonName == serializerJsonName, orElse:()=>null);
  String type(String name) => onSerializer.members.firstWhere((e) => e.name == name).unListType;
  String get members => _filters.map((e) => '${type(e.keys.first)} ${e.values.first};').toList().join('\n  ');
  String get queries => _filters.map((e) => '\"${e.values.first}\": ${e.values.first},').toList().join('\n    ');
  String get clearMembers => _filters.map((e) => '${e.values.first} = null;').toList().join('\n    ');
  String get filterClassName => '${onSerializer.serializerTypeName}Filter';

  String get queryset => 
"""Map<String, dynamic> get queryset => <String, dynamic>{
    $queries
  }..removeWhere((String key, dynamic value) => value == null);""";

  String get clear => 
"""void clear() {
    $clearMembers
  }""";

  String get filterClass =>
"""class $filterClassName {
  $members

  $queryset

  $clear
}""";
}

class JsonSerializer {
  JsonSerializeTool serializeTool;
  List<Member> members = [];
  HttpMethods httpMethodsObj;
  String jsonName;
  String serializerTypeName;
  JsonType jsonType = JsonType.Map;
  String jsonSrc;
  Filter filter;

  JsonSerializer(this.serializeTool, this.jsonName, this.jsonSrc) {
    var obj;
    try{
      obj = json.decode(jsonSrc);
    } catch(e) {
      print('*** ERROR: from \'${this.jsonName}.json\' parse Json Error: $e');
      return;
    }

    if(obj['__name__'] != null) {
      jsonName = obj['__name__'].trim();
      obj.remove('__name__');
    }

    serializerTypeName = _serializerType(jsonName);

    if(obj['__filter__'] != null) {
      filter = Filter(jsonName, this, obj['__filter__']);
      obj.remove('__filter__');
    }

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
      members.add(Member(key, value, this, serializeTool, jsonType: jsonType));
    }
    else {
      obj.forEach((String key, dynamic value) {
        members.add(Member(key, value, this, serializeTool));
      });
    }

    if(http != null)
      httpMethodsObj = HttpMethods(this, http);
  }

  String get membersSave => members.map((e) => e.save).toList().where((e) => e != null).join('\n      ');
  String get membersDelete => members.map((e) => e.delete).toList().where((e) => e != null).join('\n    ');
  Member get primaryMember => members.firstWhere((e) => e.isPrimary, orElse: () => null);

  String get fromJsonMembers => (members.map((e) => e.fromJson).toList()
                                 + [primaryMember?.hidePrimaryMemberFromJson]).where((e) => e != null).join(';\n    ');
  String get fromJson =>
"""  $serializerTypeName fromJson(${_jsonType(jsonType)} json) {
    $fromJsonMembers;
    return this;
  }""";

  String get toJsonMembers => members.map((e) => e.toJson).toList().where((e) => e != null).join('\n    ');
  String get toJson =>
    jsonType == JsonType.Map ?
"""  Map<String, dynamic> toJson() => <String, dynamic>{
    $toJsonMembers
  };""" :
"""
  List toJson() =>
    $toJsonMembers
""";

  String get fromMembers => (members.map((e) => e.from).toList()
                             + [primaryMember?.hidePrimaryMemberFrom]).where((e) => e != null).join('\n    ');
  String get from =>
"""  $serializerTypeName from($serializerTypeName instance) {
    if(instance == null) return this;
    $fromMembers
    return this;
  }""";

  String get jsonEncodeOfMembers => members.map((e) => e.jsonEncode).where((e) => e != null).toList().join('\n    ');
  String get addToFormDataOfMembers => members.map((e) => e.addToFormData).where((e) => e != null).toList().join('\n    ');
  bool get hasFileType => members.where((e) => e.isFileType).isNotEmpty;

  String get formData => hasFileType ?
"""
  FormData get _formData {
    var jsonObj = toJson();
    $jsonEncodeOfMembers
    var formData = FormData.fromMap(jsonObj, ListFormat.multi);
    $addToFormDataOfMembers
    return formData;
  }
""" : '';

  String get importSerializers => members.map((e) => e.importSerializer).toSet().join('\n');
  String get importHttpPackage => (httpMethodsObj != null) ? (serializeTool.importHttpPackage ?? httpMethodsObj.importHttpPackage) : '';
  String get serializerMembers => ([primaryMember?.hidePrimaryMember] + members.map((e) => e.member).toList()).where((e) => e != null).join('\n  ');
  String get httpMethods => httpMethodsObj != null ? httpMethodsObj.methods.join('\n') : '';
  String get filterMember => filter != null ? '\n  ${filter.filterClassName} filter = ${filter.filterClassName}();' : '';
  String get filterClass => filter != null && members.where((e) => e.isSerializerType
                                                  && e.typeSerializer.filter != null
                                                  && e.typeSerializer.filter.filterClassName == filter.filterClassName).isEmpty ? filter.filterClass : '';

  String get content =>
"""
// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
$importSerializers$importHttpPackage

class $serializerTypeName {
  $serializerTypeName();

  $serializerMembers$filterMember

$httpMethods
$fromJson

$toJson
$formData
$from
}

$filterClass
""";

  Future save(String distPath) async {
    if(members.where((e) => e.isFileType).isNotEmpty) {
      await SingleFileType().save(distPath);
    }
    await File(path.join(distPath, '$jsonName.dart')).writeAsString(content);
  }
}


class JsonSerializeTool {
  static final String config = '_config.json';
  String srcDir = './jsons';
  String distDir = './serializers';
  String indexFile = 'index.dart';
  String importHttpPackage;
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

  List<String> _splitJsons(String src) {
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

  Future _parseConfigFile(String src) async {
    var obj;
    try{
      obj = json.decode(src);
    } catch(e) {
      print('*** ERROR: from \'$config\' parse Json Error: $e');
      return;
    }

    importHttpPackage = obj['http_package'] != null ? '\nimport \'${obj['http_package']}\';\n' : null;
  }

  void run(List<String> args) async {
    await _handleArgs(args);
    List<FileSystemEntity> items = Directory(srcDir).listSync();

    for(FileSystemEntity item in items) {
      if(item is Directory) continue; // ignore directory
      if('.json' != path.extension(item.path)) continue; // ignore the not json filesif
      String baseName = path.basename(item.path);
      if(baseName.startsWith('_') && baseName != '_config.json') continue; // ignore the json files which begin with '_'
      List<String> lines = await File(item.path).readAsLines();
      String src = _removeComments(lines);
      if(baseName == config) {
        _parseConfigFile(src);
        continue;
      }
      _splitJsons(src).forEach((e) =>
        serializers.add(JsonSerializer(this, path.basenameWithoutExtension(item.path), e))
      );
    }

    await Future.forEach<JsonSerializer>(serializers,
      (e) async {
        await e.save(distDir);
        File(indexFile).writeAsStringSync('export \'${e.jsonName}.dart\';\n', mode: FileMode.append, flush: true);
      } 
    );
  }
}

void main(List<String> args) {
  var js = JsonSerializeTool();
  js.run(args);
}
