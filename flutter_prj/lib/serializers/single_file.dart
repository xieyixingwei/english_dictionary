import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;

class SingleFile {
  SingleFile(this.field, this.type);

  final String field;
  final FileType type;
  String url = '';
  MultipartFile mptFile;
  html.File htmlFile;

  MapEntry<String, MultipartFile> get file => MapEntry(field, mptFile);

  SingleFile from(SingleFile instance) {
    url = instance.url;
    mptFile = instance.mptFile;
    htmlFile = instance.htmlFile;
    return this;
  }

  /*
  Future<bool> pick() async {
    var result = await FilePicker.platform.pickFiles(type: type, withReadStream: false, allowCompression:true);
    if (result == null) return false;
    var objFile = result.files.single;

    // 注意: 需要使用 'package::dio/dio.dart';中的 MultipartFile
    mptFile = MultipartFile(objFile.readStream, objFile.size, filename: objFile.name);
    return true;
  }*/

  Future<bool> pick(Function update) async {
    var uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.click();
    uploadInput.onChange.listen((html.Event e) {
      htmlFile = uploadInput.files.first;
      if(update != null) update();
    });
    return true;
  }

}
