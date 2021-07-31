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
    print('--- ${mptFile.filename}');
    return true;
  }
}
