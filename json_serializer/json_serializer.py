
import os
import sys
import argparse
import json
from collections import OrderedDict


class JsonSerializer:
    relatedSerializer = []
    serializerTemplate = '''
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
import 'package:json_annotation/json_annotation.dart';
%relatedSerializer
part '%name.g.dart';

@JsonSerializable()
class %Name {
    %Name();

    %members

    factory %Name.fromJson(Map<String,dynamic> json) => _$%NameFromJson(json);
    Map<String, dynamic> toJson() => _$%NameToJson(this);
}
'''

    serializerTemplate_g = '''
// GENERATED CODE BY json_serializer.py - DO NOT MODIFY BY HAND
part of '%name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

%Name _$%NameFromJson(Map<String, dynamic> json) {
  return %Name()
    %serializerMembers
}

Map<String, dynamic> _$%NameToJson(%Name instance) => <String, dynamic>{
    %jsonMembers
};
'''

    def __init__(self):
        self.parser = argparse.ArgumentParser(description='Serialize json to dart class')
        self.parser.add_argument('-src',
                                default='./jsons',
                                help='Specify the directory containing the json files. The default is "./jsons".')
        self.parser.add_argument('-dist',
                                default='./serializers',
                                help='Specify the directory where the generated serializers will be placed. The default is "./serializers".')

    def _serializerClassName(self, name):
        name = ''.join([n.capitalize() for n in name.split('_')]) if name.find('_') > 0 else name.capitalize()
        return name + 'Serializer'  # 首字母大写

    def _addRelatedSerializer(self, name):
        if name not in self.relatedSerializer:
            self.relatedSerializer.append(name)

    def _typeValue(self, value):
        _type = ''
        _value = ''
        _serializerName = None
        if str(value).lower() == 'true' or str(value).lower() == 'false':
            _type = 'bool'
            _value = str(value).lower()
        elif isinstance(value, int):
            _type = 'num'
            _value = str(value)
        elif isinstance(value, float):
            _type = 'double'
            _value = str(value)
        elif isinstance(value, str):
            if 0 == value.find("$[]"): # start with $[]
                relatedSerializer = value[3:]
                self._addRelatedSerializer(relatedSerializer)
                _serializerName = self._serializerClassName(relatedSerializer)
                _type = 'List<%s>' % _serializerName
                _value = '[]'
            elif 0 == value.find("$"): # start with $
                relatedSerializer = value[1:]
                self._addRelatedSerializer(relatedSerializer)
                _serializerName = self._serializerClassName(relatedSerializer)
                _type = _serializerName
                _value = '%s()' % _type
            else:
                _type = 'String'
                _value = '\"%s\"' % value
        elif isinstance(value, dict):
            _type = 'Map<String, dynamic>'
            _value = '{}'
        elif isinstance(value, list):
            (_T, _value0, _serializerName) = self._typeValue(value[0])
            _type = 'List<%s>' % _T
            _value = '[]'
        return (_type, _value, _serializerName)

    def _member(self, key, value):
        _name = key[1:] if key[0] == '_' else key # remove the '_' prefix
        (_type, _value, _serializerName) = self._typeValue(value)
        return '%s %s = %s;' % (_type, _name, _value)

    def _serializerMember(self, key, value):
        _name = key
        if _name[0] == '_': return None # ignore member which name start with '_'
        (_type, _value, _serializerName) = self._typeValue(value)
        if _type[0:4] == 'List':
            if _serializerName:
                return '..%s = json[\'%s\'] == null\n        ? null\n        : json[\'%s\'].map<%s>((e) => %s.fromJson(e as Map<String, dynamic>)).toList()' % (_name, _name, _name, _serializerName, _serializerName)
            else:
                return '..%s = json[\'%s\'] == null\n        ? null\n        : json[\'%s\'].map<%s>((e) => e as %s).toList()' % (_name, _name, _name, _type[5:-1], _type[5:-1])
        elif _serializerName:
            return '..%s = json[\'%s\'] == null\n        ? null\n        : %s.fromJson(json[\'%s\'] as Map<String, dynamic>)' % (_name, _name, _type, _name)
        else:
            return '..%s = json[\'%s\'] as %s' % (_name, _name, _type)

    def _jsonMember(self, key, value):
        _name = key
        if _name[0] == '_': return None # ignore member which name start with '_'
        (_type, _value, _isSerializer) = self._typeValue(value)
        return '\'%s\': instance.%s' % (_name, _name)

    def _generateSerializerFromJson(self, name, json):
        members = []
        serializerMembers = []
        jsonMembers = []
        for key in json:
            members.append(self._member(key, json[key]))
            tmp = self._serializerMember(key, json[key])
            if tmp : serializerMembers.append(tmp)
            tmp = self._jsonMember(key, json[key])
            if tmp : jsonMembers.append(tmp)
        serializerClassName = self._serializerClassName(name)
        serializerFile = os.path.join(self.distPath, name + '.dart')
        serializerFile_g = os.path.join(self.distPath, name + '.g.dart')
        importRelatedSerializer = '\n'.join(['import \'%s.dart\';' % r for r in self.relatedSerializer])
        with open(serializerFile, 'w') as fd:
            content = self.serializerTemplate.replace('%relatedSerializer', importRelatedSerializer) \
                                             .replace('%name', name) \
                                             .replace('%Name', serializerClassName) \
                                             .replace('%members', '\n    '.join(members))
            fd.write(content)
        with open(serializerFile_g, 'w') as fd:
            content = self.serializerTemplate_g.replace('%name', name) \
                                               .replace('%Name', serializerClassName) \
                                               .replace('%serializerMembers', '\n    '.join(serializerMembers) + ';') \
                                               .replace('%jsonMembers', ',\n    '.join(jsonMembers))
            fd.write(content)
        with open(self.indexFile, 'a') as fd:
            fd.write('export \'%s.dart\';\n' % name)

    def _removeComments(self, content:list):
        reault = ''
        for line in content:
            pos = line.find('//') # comment char is '//'
            if pos != -1:
                line = line[0:pos] + '\n'
            reault += line
        return reault

    def run(self, argv:list):
        self.args = self.parser.parse_args(argv)
        self.distPath = os.path.abspath(self.args.dist)
        if not os.path.exists(self.distPath):
            os.mkdir(self.distPath)
        self.indexFile = os.path.join(self.distPath, 'index.dart')
        if os.path.exists(self.indexFile):
            os.remove(self.indexFile)
        srcPath = os.path.abspath(self.args.src)
        for name in os.listdir(srcPath):
            (baseName, typeName) = os.path.splitext(name)
            if typeName != '.json': # ignore not json file
                continue
            pathFile = os.path.join(srcPath, name)
            if os.path.isdir(pathFile): # ignore directory
                continue
            elif name[0] == '_': # ignore the json which file name start with '_'
                continue
            with open(pathFile, 'r') as fd:
                content = self._removeComments(fd.readlines())
                try:
                    jsonObj = json.loads(content, object_pairs_hook=OrderedDict)
                    self._generateSerializerFromJson(baseName, jsonObj)
                except Exception as e:
                    print(e)
                    print('Error on: %s'% pathFile)


def main(argv:list):
    js = JsonSerializer()
    js.run(argv[1:])


if __name__ == '__main__':
    main(sys.argv)
