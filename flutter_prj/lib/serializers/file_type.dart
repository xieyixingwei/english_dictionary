import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';


class FileSerializer {
  FileSerializer(String field, FileType type)
    : this.field = field, this.type = type;

  final FileType type;
  final String field;
  String url;
  MultipartFile mptFile;

  MapEntry<String, MultipartFile> get file => MapEntry(field, mptFile);

  FileSerializer from(FileSerializer instance) {
    url = instance.url;
    mptFile = instance.mptFile;
    return this;
  }

  Future<bool> pick() async {
    var result = await FilePicker.platform.pickFiles(type: type, withReadStream: true);
    if (result == null) return false;
    var objFile = result.files.single;
    mptFile = MultipartFile(objFile.readStream, objFile.size, filename: objFile.name);
    return true;
  }
}
