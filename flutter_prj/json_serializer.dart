import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;


class JsonSerializer {
  String _srcDir = './jsons';
  String _distDir = './serializers';
  String _indexFile = 'index.dart';
  String _className = '';
  String _importHttpPackage = '';
  String _primaryMember = '';
  List<String> _relatedSerializers = [];

  static const String _template = """
// **************************************************************************
// GENERATED CODE BY json_serializer.dart - DO NOT MODIFY BY HAND
// JsonSerializer
// **************************************************************************
%importRelatedSerializers
%importHttpPackage

class %SerializerName {
  %SerializerName();

  %members

%httpMethods
%fromJson
%toJson
}
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

  Map<String, String> _type(String type) {
    Map<String, String> ret = {
      'type': type,
    };
    if (type.startsWith('\$')) {
      String serializer = type.substring(1);
      _addRelatedSerializer(serializer);
      String serializerName = _serializerClassName(serializer);
      ret['type'] = serializerName;
    }
    return ret;
  }

  Map<String, String> _parseKV(String key, dynamic value) {
    Map<String, String> ret = {
      'type': '',
      'typeT': '',
      'name': key,
      'value': '',
    };
    if(value is bool) {
      ret['type'] = 'bool';
      ret['value'] = value.toString();
    }
    else if(value is double) {
      ret['type'] = 'double';
      ret['value'] = value.toString();
    }
    else if(value is num) {
      ret['type'] = 'num';
      ret['value'] = value.toString();
    }
    else if(value is String) {
      if(value.contains('=null')) {
        ret.addAll(_type(value.split('=').first));
        ret['value'] = null;
      }
      else if(value.startsWith('\$[]')) {
        String serializer = value.substring(3);
        _addRelatedSerializer(serializer);
        String serializerName = _serializerClassName(serializer);
        ret['type'] = 'List<$serializerName>';
        ret['typeT'] = '<$serializerName>';
        ret['value'] = '[]';
      }
      else if (value.startsWith('\$')) {
        String serializer = value.substring(1);
        _addRelatedSerializer(serializer);
        String serializerName = _serializerClassName(serializer);
        ret['type'] = serializerName;
        ret['value'] = '$serializerName()';
      }
      else {
        ret['type'] = 'String';
        ret['value'] = '\'$value\'';
      }
    }
    else if(value is Map) {
      ret['type'] = 'Map<String, dynamic>';
      ret['value'] = '{}';
    }
    else if(value is List) {
      if(value.length == 0) {
        ret['type'] = 'List';
        ret['value'] = '[]';
      }
      else {
        ret = _parseKV(key, value.first);
        ret['type'] = 'List<${ret['type']}>';
        ret['typeT'] = '<${ret['type']}>';
        ret['value'] = ret['value'] == null ? '[]' : '[${ret['value']}]';
      }
    }
    return ret;
  }

  String _trimName(String name) =>
    name.startsWith('_') ? _trimName(name.substring(1)).trim() : name.trim();

  String _member(String key, dynamic value) {
    Map<String, String> ret = _parseKV(key, value);
    String type = ret['type'];
    String name = _trimName(ret['name']); // remove the '_' prefix
    value = ret['value'];

    return value != null ? '$type $name = $value;' : '$type $name;';
  }

  String _fromMapJsonMember(String key, dynamic value) {
    if(key.startsWith('__')) return null; // ignore member which name start with '__'
    Map<String, String> ret = _parseKV(key, value);
    String type = ret['type'];
    String name = _trimName(ret['name']);

    if(type.startsWith('List')) {
      type = type.replaceAll('List<', '').replaceAll('>', '');
      if(_isSerializer(type)) {
        return '$name = json[\'$name\'] == null\n' +
               '        ? []\n' +
               '        : json[\'$name\'].map<$type>((e) => $type().fromJson(e as Map<String, dynamic>)).toList();';
      }
      else {
        return '$name = json[\'$name\'] == null\n' + 
               '        ? []\n' +
               '        : json[\'$name\'].map<$type>((e) => e as $type).toList();';
      }
    }
    else if(_isSerializer(type)) {
      return '$name = json[\'$name\'] == null\n' +
             '        ? null\n' +
             '        : $type().fromJson(json[\'$name\'] as Map<String, dynamic>);';
    }
    else
      return '$name = json[\'$name\'] as $type;';
  }

  String _toMapJsonMember(String key, dynamic value) {
    String name = key;
    if(name.startsWith('_')) return null; // ignore member which name start with '_'
    return '\'$name\': $name,';
  }

  List<String> _handleHttpMethods(Map<String, dynamic> http) {
    if(http == null) {
      _importHttpPackage = '';
      return [];
    }

    _importHttpPackage = http["http_package"];
    _importHttpPackage = _importHttpPackage != null ? 'import \'$_importHttpPackage\';\n' : '';
    
    String url = http["url"];
    List methodObjs= http["methods"];
    List<String> methods = methodObjs.map(
      (method) {
        String methodName = method["name"];

        if(methodName == "save") {
        return 
"""
  Future<$_className> save({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    $_className res = $_primaryMember == null
                               ? await this.create(data:data, queryParameters:queryParameters, cache:cache)
                               : await this.update(data:data, queryParameters:queryParameters, cache:cache);
    return res;
  }
""";
        }

        String requestUrl = url;
        method["url"] != null ? requestUrl += method["url"] : null;

        String requestType = _methodsMap[method["name"]];
        method["requst"] != null ? requestType = method["requst"] : null;

        String data = 'data:(data == null ? this.toJson() : data)';
        String queryParameters = 'queryParameters:queryParameters';
        String cache = 'cache:cache';

        if(requestType == "post") {
          return
"""
  Future<$_className> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.POST, '$requestUrl', $data, $queryParameters, $cache);
    return this.fromJson(res.data);
  }
""";
        }
        else if(requestType == "put") {
          return 
"""
  Future<$_className> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.PUT, \'$requestUrl\', $data, $queryParameters, $cache);
    return this.fromJson(res.data);
  }
""";
        }
        else if(requestType == "get") {
          return 
"""
  Future<$_className> $methodName({Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.GET, \'$requestUrl\', $queryParameters, $cache);
    return this.fromJson(res.data);
  }
""";
        }
        else if(requestType == "delete") {
          return 
"""
  Future<bool> $methodName({dynamic data, Map<String, dynamic> queryParameters, bool cache=false}) async {
    var res = await Http().request(HttpType.DELETE, \'$requestUrl\', $data, $queryParameters, $cache);
    return res.statusCode == 204;
  }
""";
        }
      }
    ).toList();

    return methods;
  }

  Map<String, String> _parseJson(String name, dynamic obj) {
    List<String> members = [];
    List<String> fromJsonMembers = [];
    List<String> toJsonMembers = [];
    List<String> httpMethods;
    String fromJson;
    String toJson;
    _className = _serializerClassName(name);

    if(obj is Map<String, dynamic>) {
      Map<String, dynamic> http = obj["__http"];
      http != null ? obj.remove("__http") : null;

      obj.forEach((String key, dynamic value) {
        if(key.endsWith('@primary')) {
          key = key.replaceAll('@primary', '');
          _primaryMember = _trimName(key);
        } else if(key.endsWith('@foreign')) {
          key = key.split('@foreign').first;
          _primaryMember = _trimName(key);
        }
        members.add(_member(key, value));

        String tmp = _fromMapJsonMember(key, value);
        tmp != null ? fromJsonMembers.add(tmp) : null;

        tmp = _toMapJsonMember(key, value);
        tmp != null ? toJsonMembers.add(tmp) : null;
      });

      httpMethods = _handleHttpMethods(http);

      fromJson = """
  $_className fromJson(Map<String, dynamic> json) {
    ${fromJsonMembers.join('\n    ')}
    return this;
  }
""";
      toJson = """
  Map<String, dynamic> toJson() => <String, dynamic>{
    ${toJsonMembers.join('\n    ')}
  };
""";
    }
    else if(obj is List<dynamic>) {
      String item;
      obj.forEach((e) {
        if(e is Map<String, dynamic> && e['__type'] == '__http') {
          httpMethods = _handleHttpMethods(e);
        }
        else if(e is String) {
          item = e;
        }
      });

      String type = item.split(' ').first;
      String name = item.split(' ').last;
      Map<String, String> ret = _type(type);
      type = ret['type'];
      members.add('List<$type> $name = [];');
      String jsonType = _isSerializer(type) ? 'Map<String, dynamic>' : type;
      String typeFromJson = _isSerializer(type) ? '$type().fromJson(e)' : 'e';
      String typeToJson = _isSerializer(type) ? 'e.toJson()' : 'e';
      fromJson = """
  $_className fromJson(List<$jsonType> json) {
    $name = json == null
                  ? null
                  : json.map<$type>((e) => $typeFromJson).toList();
    return this;
  }
""";
      toJson = """
  List<$jsonType> toJson() => $name.map<$jsonType>((e) => $typeToJson).toList();""";
    }
    else
      return null;

    return {
      'fileName': name,
      'importRelatedSerializers': _relatedSerializers.map<String>((e) => 'import \'$e.dart\';').toList().join('\n'),
      'seriliazerName': _className,
      'members': members.join('\n  '),
      'httpMethods': httpMethods.join('\n'),
      'fromJson': fromJson,
      'toJson': toJson,
    };
  }

  Future<bool> _generateSerializerFromTemplate(Map<String, String> info) async {
    String content = _template.replaceAll('%importRelatedSerializers', info['importRelatedSerializers'])
                              .replaceAll('%importHttpPackage', _importHttpPackage)
                              .replaceAll('%SerializerName', info['seriliazerName'])
                              .replaceAll('%members', info['members'])
                              .replaceAll('%httpMethods', info['httpMethods'])
                              .replaceAll('%fromJson', info['fromJson'])
                              .replaceAll('%toJson', info['toJson']);

    await File(path.join(_distDir, '${info['fileName']}.dart')).writeAsString(content);
    File(_indexFile).writeAsStringSync('export \'${info['fileName']}.dart\';\n', mode: FileMode.append, flush: true);
    return true;
  }

  static const Map<String, String> _methodsMap = {
    "create": "post",
    "update": "put",
    "retrieve": "get",
    "list": "get",
    "delete": "delete",
  };

  void run(List<String> args) {
    _handleArgs(args);

    Directory(_srcDir).list().listen(
      (FileSystemEntity entity) async {
        if('.json' != path.extension(entity.path)) return;
        if(path.basename(entity.path).startsWith('_')) return;
        List<String> lines = await File(entity.path).readAsLines();
        var obj = json.decode(_removeComments(lines), );
        _relatedSerializers.clear();
        Map<String, String> info = _parseJson(path.basenameWithoutExtension(entity.path), obj);
        if(info == null) return;
        await _generateSerializerFromTemplate(info);
      }
    );
  }
}

void main(List<String> args) {
  var js = JsonSerializer();
  js.run(args);
}
